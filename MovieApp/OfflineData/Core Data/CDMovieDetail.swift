//
//  CDMovieDetail.swift
//  MovieApp
//
//  Created by Aman Gupta on 17/10/23.
//

import Foundation
import CoreData
import Core

final class CDMovieDetail: NSManagedObject {

    static func add(_ detail: MovieDetail, _ metaData: MovieMetaData, in context: NSManagedObjectContext) {
        context.performAndWait {
            let cdMovie = CDMovieDetail(context: context)
            cdMovie.overview = detail.overview
            cdMovie.releaseDate = detail.releaseDate
            cdMovie.id = Int32(detail.id)
            cdMovie.title = detail.title
            cdMovie.voteAverage = detail.voteAverage ?? 0
            cdMovie.budget = Int32(detail.budget ?? 0)
            cdMovie.revenue =  Int32(detail.revenue ?? 0)
            cdMovie.runtime = Int32(detail.runtime ?? 0)
            cdMovie.isFavourite = detail.isFavourite
            cdMovie.fullPath = detail.posterPath
            cdMovie.thumbPath = metaData.posterPath
            cdMovie.genresSet = CDGenre.create(genres: detail.genres, context: context)
            cdMovie.spokenLanguagesSet = CDLanguage.create(languages: detail.spokenLanguages, context: context)
        }
    }    
}

extension CDMovieDetail: MovieDetailType {
    
    var genres: [CDGenre]? {
        genresSet?.allObjects as? [CDGenre]
    }
    
    var spokenLanguages: [CDLanguage]? {
        spokenLanguagesSet?.allObjects as? [CDLanguage]
    }
}
