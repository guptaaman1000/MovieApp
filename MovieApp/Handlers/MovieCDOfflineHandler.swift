//
//  MovieCDOfflineHandler.swift
//  MovieApp
//
//  Created by Aman Gupta on 18/10/23.
//

import Foundation
import Combine
import Core

/// Fetch movies offline using Core Data
final class MovieCDOfflineHandler: MovieHandlerType {

    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }

    func getMovieList(page: Int) -> AnyPublisher<MovieListResponse, NetworkError> {
        return Future<MovieListResponse, NetworkError> { promise in
            Task {
                let result = await self.coreDataManager.getMatchingEntities(CDMovieDetail.self)
                let movieList = result.map { MovieMetaData(detail: $0) }
                let response = MovieListResponse(movieList: movieList)
                promise(.success(response))
            }
        }
        .eraseToAnyPublisher()
    }

    func getMovieDetail(id: Int) -> AnyPublisher<MovieDetail, NetworkError> {
        return Future<MovieDetail, NetworkError> { promise in
            Task {
                let predicate = NSPredicate(format: "id=%d", id)
                let result = await self.coreDataManager.getMatchingEntities(CDMovieDetail.self, with: predicate).first
                let movieDetail = result.map { MovieDetail(detail: $0) }
                if let movieDetail {
                    promise(.success(movieDetail))
                } else {
                    promise(.failure(.failedToMapObject))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
