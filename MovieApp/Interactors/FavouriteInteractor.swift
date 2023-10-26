//
//  FavouriteInteractor.swift
//  MovieApp
//
//  Created by Aman Gupta on 25/10/23.
//

import Foundation

//sourcery: AutoMockable
protocol FavouriteInteractorType: AnyObject {
    func handleFavourite(detail: MovieDetail, metaData: MovieMetaData)
    func updateFavourite(detail: MovieDetail) async -> MovieDetail
}
