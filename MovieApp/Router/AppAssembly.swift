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

        container.register(CoreDataManager.self) { resolver in
            return CoreDataManager(dataModelName: "Movie", isStoredInMemoryOnly: false)
        }.inObjectScope(.container)
        
        container.register(MovieOptionsViewModel.self) { resolver in
            guard let appRouter = resolver.resolve(AppRouterType.self) else {
                fatalError("Could not resolve App router")
            }
            return MovieOptionsViewModel(appRouter: appRouter)
        }
        
        container.register(MovieListViewModel.self) { (resolver, type: MovieType) in
            guard let movieHandler = resolver.resolve(MovieHandlerType.self, argument: type) else {
                fatalError("Could not resolve Movie handler")
            }
            guard let appRouter = resolver.resolve(AppRouterType.self) else {
                fatalError("Could not resolve App router")
            }
            return MovieListViewModel(movieHandler: movieHandler, appRouter: appRouter, movieType: type)
        }
        
        container.register(MovieDetailViewModel.self) { (resolver, metaData: MovieMetaData, type: MovieType) in
            guard let movieHandler = resolver.resolve(MovieHandlerType.self, argument: type) else {
                fatalError("Could not resolve Movie handler")
            }
            guard let favouriteHandler = resolver.resolve(FavouriteHandlerType.self) else {
                fatalError("Could not resolve Favourite handler")
            }
            return MovieDetailViewModel(movieHandler: movieHandler, favouriteHandler: favouriteHandler, metaData: metaData)
        }
        
        container.register(NetworkClientType.self) { _ in
            RESTNetworkClient()
        }

        container.register(MovieHandlerType.self) { (resolver, type: MovieType) in
            if type == .online {
                guard let networkType = resolver.resolve(NetworkClientType.self) else { fatalError("Could not resolve Network client") }
                return MovieNetworkHandler(network: networkType)
            } else {
                guard let coreDataManager = resolver.resolve(CoreDataManager.self) else { fatalError("Could not resolve CoreDataManager") }
                return MovieCDOfflineHandler(coreDataManager: coreDataManager)
            }
        }
        
        container.register(FavouriteHandlerType.self) { resolver in
            guard let coreDataManager = resolver.resolve(CoreDataManager.self) else { fatalError("Could not resolve CoreDataManager") }
            return FavouriteCDHandler(coreDataManager: coreDataManager)
        }
    }
}
