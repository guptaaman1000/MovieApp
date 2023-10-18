//
//  MovieNetworkInteractor.swift
//  MovieApp
//
//  Created by Aman Gupta on 28/07/21.
//  Copyright © 2021 Aman Gupta. All rights reserved.
//

import Foundation
import Combine
import Core

class MovieNetworkInteractor: MovieInteractorType {
    
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

        return network.request(request).map { (response: MovieDetail) -> MovieDetail in
            var finalResponse = response
            finalResponse.isFavourite = CDMovieDetail.getDetail(id: response.id) != nil
            return finalResponse
        }.eraseToAnyPublisher()
    }
}
