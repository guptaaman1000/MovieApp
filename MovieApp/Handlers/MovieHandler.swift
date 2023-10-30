//
//  MovieHandlerType.swift
//  MovieApp
//
//  Created by Aman Gupta on 18/10/23.
//

import Foundation
import Combine
import Core

/// Protocol to fetch movie info
protocol MovieHandlerType: AnyObject {
    func getMovieList(page: Int) -> AnyPublisher<MovieListResponse, NetworkError>
    func getMovieDetail(id: Int) -> AnyPublisher<MovieDetail, NetworkError>
}
