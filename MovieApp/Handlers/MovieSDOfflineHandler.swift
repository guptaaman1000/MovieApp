//
//  MovieSDOfflineHandler.swift
//  MovieApp
//
//  Created by Aman Gupta on 24/10/23.
//

import Foundation
import Combine
import Core

/// Fetch movies offline using Swift Data
final class MovieSDOfflineHandler: MovieHandlerType {

    private let swiftDataManager: SwiftDataManager
    
    init(swiftDataManager: SwiftDataManager) {
        self.swiftDataManager = swiftDataManager
    }

    func getMovieList(page: Int) -> AnyPublisher<MovieListResponse, NetworkError> {
        return Future<MovieListResponse, Never> { promise in
            Task {
                let movieList = await self.swiftDataManager.getMatchingEntities(SDMovieDetail.self).map { MovieMetaData(detail: $0) }
                let response = MovieListResponse(movieList: movieList)
                promise(.success(response))
            }
        }
        .setFailureType(to: NetworkError.self)
        .eraseToAnyPublisher()
    }

    func getMovieDetail(id: Int) -> AnyPublisher<MovieDetail, NetworkError> {
        return Future<MovieDetail, Never> { promise in
            Task {
                let id = Int32(id)
                let predicate = #Predicate<SDMovieDetail> { $0.id == id }
                let result = await self.swiftDataManager.getMatchingEntities(SDMovieDetail.self, with: predicate).first
                let movieDetail = result.map { MovieDetail(detail: $0) }
                promise(.success(movieDetail!))
            }
        }
        .setFailureType(to: NetworkError.self)
        .eraseToAnyPublisher()
    }    
}
