//
//  MovieOptionsViewModel.swift
//  MovieApp
//
//  Created by Aman Gupta on 19/10/23.
//

import Foundation
import SwiftUI

class MovieOptionsViewModel {
    
    private let appRouter: AppRouterType
    
    init(appRouter: AppRouterType) {
        self.appRouter = appRouter
    }
    
    func getMovieListView(type: MovieType) -> MovieListView {
        return appRouter.displayMovieList(of: type)
    }
}
