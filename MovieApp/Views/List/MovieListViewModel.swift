//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by Aman Gupta on 19/10/23.
//

import Foundation
import Combine

@Observable class MovieListViewModel {

    private let movieInteractor: MovieInteractorType
    private let appRouter: AppRouterType
    private var subscription: AnyCancellable?
    private var currentPage = 0
    private var totalPages = 1
    
    var dataSource = [MovieMetaData]()
    let movieType: MovieType

    init(movieInteractor: MovieInteractorType, appRouter: AppRouterType, movieType: MovieType) {
        self.movieInteractor = movieInteractor
        self.appRouter = appRouter
        self.movieType = movieType
    }
    
    func fetchMovies() {
        subscription = movieInteractor.getMovieList(page: currentPage + 1)
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.totalPages = response.totalPages
                self.currentPage = response.page
                self.dataSource = movieType == .online ? self.dataSource + response.movieList : response.movieList
            }
    }
}

extension MovieListViewModel {
    func getMovieDetailView(item: MovieMetaData) -> MovieDetailView {
        return appRouter.displayMovieDetail(metaData: item, type: movieType)
    }
}
