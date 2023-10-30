//
//  FavouriteHandlerType.swift
//  MovieApp
//
//  Created by Aman Gupta on 25/10/23.
//

import Foundation

/// Protocol to manage favourites for movies
protocol FavouriteHandlerType: AnyObject {
    func handleFavourite(detail: MovieDetail, metaData: MovieMetaData)
    func updateFavourite(detail: MovieDetail) async -> MovieDetail
}
