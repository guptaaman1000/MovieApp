//
//  MovieDetail.swift
//  MovieApp
//
//  Created by Aman Gupta on 28/07/21.
//  Copyright © 2021 Aman Gupta. All rights reserved.
//

import Foundation
import Core

struct MovieDetail: Decodable {
    
    let posterPath: String?
    let overview: String?
    let releaseDate: String?
    let genres: [Genre]?
    let spokenLanguages: [Language]?
    let id: Int
    let title: String?
    let voteAverage: Float?
    let budget: Int?
    let revenue: Int?
    let runtime: Int?
    var isFavourite = false
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case spokenLanguages = "spoken_languages"
        case overview
        case genres
        case id
        case title
        case budget
        case revenue
        case runtime
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let poster = try? values.decode(String.self, forKey: .posterPath)

        if let poster = poster {
            posterPath = "\(BaseUrlType.imageUrl.rawValue)/w500\(poster)"
        } else {
            posterPath = nil
        }

        overview = try? values.decode(String.self, forKey: .overview)
        releaseDate = try? values.decode(String.self, forKey: .releaseDate)
        genres = try? values.decode([Genre].self, forKey: .genres)
        spokenLanguages = try? values.decode([Language].self, forKey: .spokenLanguages)
        id = try values.decode(Int.self, forKey: .id)
        title = try? values.decode(String.self, forKey: .title)
        voteAverage = try? values.decode(Float.self, forKey: .voteAverage)
        budget = try? values.decode(Int.self, forKey: .budget)
        revenue = try? values.decode(Int.self, forKey: .revenue)
        runtime = try? values.decode(Int.self, forKey: .runtime)
    }

    init(detail: CDMovieDetail) {
        self.overview = detail.overview
        self.releaseDate = detail.releaseDate
        self.id = Int(detail.id)
        self.title = detail.title
        self.voteAverage = detail.voteAverage
        self.budget = Int(detail.budget)
        self.revenue =  Int(detail.revenue)
        self.runtime = Int(detail.runtime)
        self.isFavourite = detail.isFavourite
        self.posterPath = detail.fullPath
        self.genres = (detail.genres?.allObjects as? [CDGenre])?.map {Genre(detail: $0)}
        self.spokenLanguages = (detail.spokenLanguages?.allObjects as? [CDLanguage])?.map {Language(detail: $0)}
    }
}

struct Genre: Decodable {
    
    let id: Int
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try? values.decode(String.self, forKey: .name)
    }

    init(detail: CDGenre) {
        self.id = Int(detail.id)
        self.name = detail.name
    }
}

struct Language: Decodable {
    
    let isoCode: String
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case isoCode = "iso_639_1"
        case name
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isoCode = try values.decode(String.self, forKey: .isoCode)
        name = try? values.decode(String.self, forKey: .name)
    }

    init(detail: CDLanguage) {
        self.isoCode = detail.isoCode ?? ""
        self.name = detail.name
    }
}
