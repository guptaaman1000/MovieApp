//
//  CDMovieDetail.swift
//  MovieApp
//
//  Created by Aman Gupta on 17/10/23.
//

import Foundation
import CoreData
import Core

class CDMovieDetail: NSManagedObject {

    static func getList() -> [CDMovieDetail] {

        let fetchRequest = NSFetchRequest<CDMovieDetail>(entityName: CDMovieDetail.name)

        do {
            let movies: [CDMovieDetail] = try CoreDataManager.shared.mainManagedObjectContext.fetch(fetchRequest)
            return movies
        } catch {
            print("Unable to fetch movie list with error - \(error)")
        }
        return []
    }

    static func getDetail(id: Int) -> CDMovieDetail? {

        let fetchRequest = NSFetchRequest<CDMovieDetail>(entityName: CDMovieDetail.name)
        fetchRequest.predicate = NSPredicate(format: "id=%d", id)
        fetchRequest.fetchLimit = 1

        do {
            let movies: [CDMovieDetail] = try CoreDataManager.shared.mainManagedObjectContext.fetch(fetchRequest)
            return movies.first
        } catch {
            print("Unable to fetch movie with id - \(id) and error - \(error)")
        }
        return nil
    }

    static func delete(id: Int) {

        let context = CoreDataManager.shared.newChildContext()
        let fetchRequest = NSFetchRequest<CDMovieDetail>(entityName: CDMovieDetail.name)
        fetchRequest.predicate = NSPredicate(format: "id=%d", id)
        fetchRequest.fetchLimit = 1

        do {
            let movies: [CDMovieDetail] = try context.fetch(fetchRequest)
            context.delete(movies[0])
        } catch {
            print("Unable to fetch movie with id - \(id) and error - \(error)")
        }

        CoreDataManager.shared.save(context: context)
    }

    static func add(_ detail: MovieDetail, _ metaData: MovieMetaData) {

        let context = CoreDataManager.shared.newChildContext()
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

        CoreDataManager.shared.save(context: context)
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
