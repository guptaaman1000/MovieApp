//
//  MovieOfflineInteractor.swift
//  MovieApp
//
//  Created by Aman Gupta on 18/10/23.
//

import Foundation
import Combine
import Core

class MovieOfflineInteractor: MovieInteractorType {

    func getMovieList(page: Int) -> AnyPublisher<MovieListResponse, NetworkError> {
        let movieList = CDMovieDetail.getList().map { MovieMetaData(detail: $0) }
        let response = MovieListResponse(movieList: movieList)
        return Just(response)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }

    func getMovieDetail(id: Int) -> AnyPublisher<MovieDetail, NetworkError> {
        let movieDetail = CDMovieDetail.getDetail(id: id).map { MovieDetail(detail: $0) }
        return Just(movieDetail!)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }
}
