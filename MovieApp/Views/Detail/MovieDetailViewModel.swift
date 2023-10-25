//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by Aman Gupta on 19/10/23.
//

import Foundation
import Combine

@Observable class MovieDetailViewModel {
    
    private let movieInteractor: MovieInteractorType
    private let favouriteInteractor: FavouriteInteractorType
    private let metaData: MovieMetaData
    private var subscription: AnyCancellable?
    
    var dataSource: MovieDetail?
    
    init(movieInteractor: MovieInteractorType, favouriteInteractor: FavouriteInteractorType, metaData: MovieMetaData) {
        self.movieInteractor = movieInteractor
        self.favouriteInteractor = favouriteInteractor
        self.metaData = metaData
    }
    
    func fetchMovieDetail() {
             
        subscription = movieInteractor.getMovieDetail(id: metaData.id)
            .receive(on: DispatchQueue.main)
            .sink { _ in
            
        } receiveValue: { [weak self] response in
            guard let self = self else { return }
            self.dataSource = favouriteInteractor.updateFavourite(detail: response)
        }
    }

    func handleFavourite() {
        if var detail = dataSource {
            detail.isFavourite.toggle()
            dataSource = detail
            favouriteInteractor.handleFavourite(detail: detail, metaData: metaData)
        }
    }
}
