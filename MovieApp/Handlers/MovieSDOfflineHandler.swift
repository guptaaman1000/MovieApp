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

    func getMovieList(page: Int) -> AnyPublisher<MovieListResponse, NetworkError> {
        return Future<MovieListResponse, Never> { promise in
            Task {
                let movieList = await SDMovieDetail.getList().map { MovieMetaData(detail: $0) }
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
                let movieDetail = await SDMovieDetail.getDetail(id: id).map { MovieDetail(detail: $0) }
                promise(.success(movieDetail!))
            }
        }
        .setFailureType(to: NetworkError.self)
        .eraseToAnyPublisher()
    }    
}
