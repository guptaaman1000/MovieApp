//
//  FavouriteCDInteractor.swift
//  MovieApp
//
//  Created by Aman Gupta on 25/10/23.
//

import Foundation

class FavouriteCDInteractor: FavouriteInteractorType {
    
    func handleFavourite(detail: MovieDetail, metaData: MovieMetaData) {
        if !detail.isFavourite && CDMovieDetail.getDetail(id: detail.id) != nil {
            CDMovieDetail.delete(id: detail.id)
        } else if detail.isFavourite && CDMovieDetail.getDetail(id: detail.id) == nil {
            CDMovieDetail.add(detail, metaData)
        }
    }
    
    func updateFavourite(detail: MovieDetail) -> MovieDetail {
        var finalResponse = detail
        finalResponse.isFavourite = CDMovieDetail.getDetail(id: detail.id) != nil
        return finalResponse
    }
}
