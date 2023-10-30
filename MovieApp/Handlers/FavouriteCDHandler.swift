//
//  FavouriteCDHandler.swift
//  MovieApp
//
//  Created by Aman Gupta on 25/10/23.
//

import Foundation

/// Handle favourites offline through Core Data
final class FavouriteCDHandler: FavouriteHandlerType {
    
    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }

    func handleFavourite(detail: MovieDetail, metaData: MovieMetaData) {
        
        let childContext = self.coreDataManager.newChildContext()
        let predicate = NSPredicate(format: "id=%d", detail.id)
        let movieDetail = coreDataManager.getMatchingEntities(CDMovieDetail.self, with: predicate).first
        
        if !detail.isFavourite && movieDetail != nil {
            coreDataManager.deleteEntities(CDMovieDetail.self, with: predicate, in: childContext)
        } else if detail.isFavourite && movieDetail == nil {
            CDMovieDetail.add(detail, metaData, in: childContext)
        }
        
        coreDataManager.save(childContext)
    }
    
    func updateFavourite(detail: MovieDetail) async -> MovieDetail {
        let predicate = NSPredicate(format: "id=%d", detail.id)
        let result = await coreDataManager.getMatchingEntities(CDMovieDetail.self, with: predicate).first != nil
        var finalResponse = detail
        finalResponse.isFavourite = result
        return finalResponse
    }
}
