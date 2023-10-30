//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by Aman Gupta on 19/10/23.
//

import Foundation
import Combine

@Observable class MovieDetailViewModel {
    
    private let movieHandler: MovieHandlerType
    private let favouriteHandler: FavouriteHandlerType
    private let metaData: MovieMetaData
    private var subscription: AnyCancellable?
    
    var dataSource: MovieDetail?
    
    init(movieHandler: MovieHandlerType, favouriteHandler: FavouriteHandlerType, metaData: MovieMetaData) {
        self.movieHandler = movieHandler
        self.favouriteHandler = favouriteHandler
        self.metaData = metaData
    }
    
    func fetchMovieDetail() {
        subscription = movieHandler.getMovieDetail(id: metaData.id)
            .receive(on: DispatchQueue.main)
            .sink { _ in
            
        } receiveValue: { [weak self] response in
            guard let self = self else { return }
            Task {
                self.dataSource = await self.favouriteHandler.updateFavourite(detail: response)
            }
        }
    }

    func handleFavourite() {
        if var detail = dataSource {
            detail.isFavourite.toggle()
            dataSource = detail
            favouriteHandler.handleFavourite(detail: detail, metaData: metaData)
        }
    }
}
