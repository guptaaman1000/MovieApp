//
//  MovieNetworkHandler.swift
//  MovieApp
//
//  Created by Aman Gupta on 18/10/23.
//

import Foundation
import Combine
import Core

/// Fetch movies from backend server
final class MovieNetworkHandler: MovieHandlerType {
    
    private let network : NetworkClientType
    
    init(network: NetworkClientType) {
        self.network = network
    }
    
    func getMovieList(page: Int) -> AnyPublisher<MovieListResponse, NetworkError> {
        let params = [("page", "\(page)")]
        let request = Request(method: .get, path: "movie/now_playing", params: params)
        return network.request(request)
    }
    
    func getMovieDetail(id: Int) -> AnyPublisher<MovieDetail, NetworkError> {
        let path = "movie/\(id)"
        let request = Request(method: .get, path: path, params: [])
        return network.request(request)
    }
}
