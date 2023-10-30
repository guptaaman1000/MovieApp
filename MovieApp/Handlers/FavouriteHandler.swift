//
//  FavouriteHandlerType.swift
//  MovieApp
//
//  Created by Aman Gupta on 25/10/23.
//

import Foundation

protocol FavouriteHandlerType: AnyObject {
    func handleFavourite(detail: MovieDetail, metaData: MovieMetaData)
    func updateFavourite(detail: MovieDetail) async -> MovieDetail
}
