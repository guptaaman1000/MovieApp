//
//  AppRouter.swift
//  MovieApp
//
//  Created by Aman Gupta on 19/10/23.
//

import Swinject
import Foundation

//sourcery: AutoMockable
protocol AppRouterType {
    func displayMovieOptionsView() -> MovieOptionsView
    func displayMovieList(of type: MovieType) -> MovieListView
    func displayMovieDetail(metaData: MovieMetaData, type: MovieType) -> MovieDetailView
}

class AppRouter: AppRouterType {
    
    let resolver: Resolver
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    func displayMovieOptionsView() -> MovieOptionsView {
        let viewModel = resolver.resolve(MovieOptionsViewModel.self)!
        return MovieOptionsView(viewModel: viewModel)
    }
    
    func displayMovieList(of type: MovieType) -> MovieListView {
        let viewModel = resolver.resolve(MovieListViewModel.self, argument: type)!
        return MovieListView(viewModel: viewModel)
    }
    
    func displayMovieDetail(metaData: MovieMetaData, type: MovieType) -> MovieDetailView {
        let viewModel = resolver.resolve(MovieDetailViewModel.self, arguments: metaData, type)!
        return MovieDetailView(viewModel: viewModel)
    }
}
