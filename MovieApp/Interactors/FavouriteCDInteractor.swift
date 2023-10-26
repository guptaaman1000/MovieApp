//
//  FavouriteCDInteractor.swift
//  MovieApp
//
//  Created by Aman Gupta on 25/10/23.
//

import Foundation

class FavouriteCDInteractor: FavouriteInteractorType {
    
    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }

    func handleFavourite(detail: MovieDetail, metaData: MovieMetaData) {
        
        let mainContext = self.coreDataManager.mainManagedObjectContext
        let childContext = self.coreDataManager.newChildContext()
        let predicate = NSPredicate(format: "id=%d", detail.id)
        let movieDetail = CDMovieDetail.where(predicate: predicate, in: mainContext).first
        
        if !detail.isFavourite && movieDetail != nil {
            CDMovieDetail.deleteAllWhere(predicate: predicate, in: childContext)
        } else if detail.isFavourite && movieDetail == nil {
            CDMovieDetail.add(detail, metaData, in: childContext)
        }
        
        coreDataManager.save(childContext)
    }
    
    func updateFavourite(detail: MovieDetail) async -> MovieDetail {
        let context = self.coreDataManager.mainManagedObjectContext
        let predicate = NSPredicate(format: "id=%d", detail.id)
        let result = await CDMovieDetail.where(predicate: predicate, in: context).first != nil
        var finalResponse = detail
        finalResponse.isFavourite = result
        return finalResponse
    }
}
