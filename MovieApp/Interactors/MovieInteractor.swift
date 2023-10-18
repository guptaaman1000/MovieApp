//
//  MovieInteractor.swift
//  MovieApp
//
//  Created by Aman Gupta on 28/07/21.
//  Copyright © 2021 Aman Gupta. All rights reserved.
//

import Foundation
import Combine
import Core

//sourcery: AutoMockable
protocol MovieInteractorType: AnyObject {
    func getMovieList(page: Int) -> AnyPublisher<MovieListResponse, NetworkError>
    func getMovieDetail(id: Int) -> AnyPublisher<MovieDetail, NetworkError>
}

extension MovieInteractorType {
    
    func handleFavourite(detail: MovieDetail, metaData: MovieMetaData) {
        if !detail.isFavourite && CDMovieDetail.getDetail(id: detail.id) != nil {
            CDMovieDetail.delete(id: detail.id)
        } else if detail.isFavourite && CDMovieDetail.getDetail(id: detail.id) == nil {
            CDMovieDetail.add(detail, metaData)
        }
    }
}
