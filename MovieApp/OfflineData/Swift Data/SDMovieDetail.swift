//
//  SDMovieDetail.swift
//  MovieApp
//
//  Created by Aman Gupta on 24/10/23.
//

import Foundation
import SwiftData

@Model
final class SDMovieDetail: MovieDetailType {
    
    let budget: Int32
    let fullPath: String?
    let id: Int32
    let isFavourite: Bool
    let overview: String?
    let releaseDate: String?
    let revenue: Int32
    let runtime: Int32
    let thumbPath: String?
    let title: String?
    let voteAverage: Float
    
    @Relationship(deleteRule: .cascade) let genres: [SDGenre]?
    @Relationship(deleteRule: .cascade) let spokenLanguages: [SDLanguage]?
    
    init(detail: MovieDetail, metaData: MovieMetaData) {
        self.budget = Int32(detail.budget ?? 0)
        self.fullPath = detail.posterPath
        self.id = Int32(detail.id)
        self.isFavourite = detail.isFavourite
        self.overview = detail.overview
        self.releaseDate = detail.releaseDate
        self.revenue = Int32(detail.revenue ?? 0)
        self.runtime = Int32(detail.runtime ?? 0)
        self.thumbPath = metaData.posterPath
        self.title = detail.title
        self.voteAverage = detail.voteAverage ?? 0
        //self.genres = SDGenre.create(from: detail.genres)
        //self.spokenLanguages = SDLanguage.create(from: detail.spokenLanguages)
    }
}

extension SDMovieDetail {
    
    static func add(_ detail: MovieDetail, _ metaData: MovieMetaData, in context: ModelContext) {
        let movie = SDMovieDetail(detail: detail, metaData: metaData)
        context.insert(movie)
    }
}
