//
//  FavouriteSDInteractor.swift
//  MovieApp
//
//  Created by Aman Gupta on 25/10/23.
//

import Foundation

class FavouriteSDInteractor: FavouriteInteractorType {
    
    @MainActor func handleFavourite(detail: MovieDetail, metaData: MovieMetaData) {
        let movieDetail = SDMovieDetail.getDetail(id: detail.id)
        if !detail.isFavourite && movieDetail != nil {
            SDMovieDetail.delete(id: detail.id)
        } else if detail.isFavourite && movieDetail == nil {
            SDMovieDetail.add(detail, metaData)
        }
    }
    
    @MainActor func updateFavourite(detail: MovieDetail) -> MovieDetail {
        var finalResponse = detail
        finalResponse.isFavourite = SDMovieDetail.getDetail(id: detail.id) != nil
        return finalResponse
    }
}
