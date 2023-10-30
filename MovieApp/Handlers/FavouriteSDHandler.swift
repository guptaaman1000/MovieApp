//
//  FavouriteSDHandler.swift
//  MovieApp
//
//  Created by Aman Gupta on 25/10/23.
//

import Foundation
import Core

/// Handle favourites offline through Swift Data
final class FavouriteSDHandler: FavouriteHandlerType {
    
    private let swiftDataManager: SwiftDataManager
    
    init(swiftDataManager: SwiftDataManager) {
        self.swiftDataManager = swiftDataManager
    }

    @MainActor func handleFavourite(detail: MovieDetail, metaData: MovieMetaData) {
        
        let id = Int32(detail.id)
        let childContext = swiftDataManager.newContext()
        let predicate = #Predicate<SDMovieDetail> { $0.id == id }
        let movieDetail = swiftDataManager.getMatchingEntities(SDMovieDetail.self, with: predicate).first

        if !detail.isFavourite && movieDetail != nil {
            swiftDataManager.deleteEntities(SDMovieDetail.self, with: predicate, in: childContext)
        } else if detail.isFavourite && movieDetail == nil {
            SDMovieDetail.add(detail, metaData, in: childContext)
        }
        
        swiftDataManager.save(childContext)
    }
    
    @MainActor func updateFavourite(detail: MovieDetail) -> MovieDetail {
        let id = Int32(detail.id)
        let predicate = #Predicate<SDMovieDetail> { $0.id == id }
        let result = swiftDataManager.getMatchingEntities(SDMovieDetail.self, with: predicate).first != nil
        var finalResponse = detail
        finalResponse.isFavourite = result
        return finalResponse
    }
}
