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
    
    @MainActor
    static func getList() -> [SDMovieDetail] {

        let descriptor = FetchDescriptor<SDMovieDetail>()
        let context = SwiftDataManager.shared.mainContext
        
        do {
            let movies = try context.fetch(descriptor)
            return movies
        } catch {
            print("Unable to fetch movie list with error - \(error)")
        }
        return []
    }
    
    @MainActor 
    static func getDetail(id: Int) -> SDMovieDetail? {

        let id = Int32(id)
        let context = SwiftDataManager.shared.mainContext
        let predicate = #Predicate<SDMovieDetail> { $0.id == id }
        var descriptor = FetchDescriptor<SDMovieDetail>(predicate: predicate)
        descriptor.fetchLimit = 1
        
        do {
            let movies = try context.fetch(descriptor)
            return movies.first
        } catch {
            print("Unable to fetch movie with id - \(id) and error - \(error)")
        }
        return nil
    }
    
    static func delete(id: Int) {

        let id = Int32(id)
        let context = SwiftDataManager.shared.newContext()
        let predicate = #Predicate<SDMovieDetail> { $0.id == id }
        
        do {
            try context.delete(model: SDMovieDetail.self, where: predicate)
            try context.save()
        } catch {
            print("Unable to delete movie with id - \(id) and error - \(error)")
        }
    }
    
    static func add(_ detail: MovieDetail, _ metaData: MovieMetaData) {

        let movie = SDMovieDetail(detail: detail, metaData: metaData)
        let context = SwiftDataManager.shared.newContext()
        context.insert(movie)
        try? context.save()
    }
}
