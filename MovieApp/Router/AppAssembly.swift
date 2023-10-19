//
//  AppAssembly.swift
//  MovieApp
//
//  Created by Aman Gupta on 19/10/23.
//

import Foundation
import Swinject
import Core

class AppAssembly: Assembly {
    
    func assemble(container: Container) {
                
        container.register(AppRouterType.self) { resolver in
            return AppRouter(resolver: resolver)
        }

        container.register(MovieOptionsViewModel.self) { resolver in
            guard let appRouter = resolver.resolve(AppRouterType.self) else {
                fatalError("Could not resolve App router")
            }
            return MovieOptionsViewModel(appRouter: appRouter)
        }
        
        container.register(MovieListViewModel.self) { (resolver, type: MovieType) in
            guard let movieInteractor = resolver.resolve(MovieInteractorType.self, argument: type) else {
                fatalError("Could not resolve Movie interactor")
            }
            guard let appRouter = resolver.resolve(AppRouterType.self) else {
                fatalError("Could not resolve App router")
            }
            return MovieListViewModel(movieInteractor: movieInteractor, appRouter: appRouter, movieType: type)
        }
        
        container.register(MovieDetailViewModel.self) { (resolver, metaData: MovieMetaData, type: MovieType) in
            guard let movieInteractor = resolver.resolve(MovieInteractorType.self, argument: type) else {
                fatalError("Could not resolve Movie interactor")
            }
            return MovieDetailViewModel(movieInteractor: movieInteractor, metaData: metaData)
        }
        
        container.register(NetworkClientType.self) { _ in
            RESTNetworkClient()
        }

        container.register(MovieInteractorType.self) { (resolver, type: MovieType) in
            if type == .online {
                guard let networkType = resolver.resolve(NetworkClientType.self) else { fatalError("Could not resolve Network client") }
                return MovieNetworkInteractor(network: networkType)
            } else {
                return MovieOfflineInteractor()
            }
        }
    }
}
