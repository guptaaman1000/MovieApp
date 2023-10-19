//
//  MovieMetaData.swift
//  MovieApp
//
//  Created by Aman Gupta on 18/10/23.
//

import Foundation
import Core

struct MovieMetaData: Decodable, Identifiable, Equatable {
    
    let posterPath: String?
    let id: Int
    let title: String?
    let voteAverage: Float?
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case id
        case title
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let poster = try? values.decode(String.self, forKey: .posterPath)

        if let poster = poster {
            posterPath = "\(BaseUrlType.imageUrl.rawValue)/w200\(poster)"
        } else {
            posterPath = nil
        }

        id = try values.decode(Int.self, forKey: .id)
        title = try? values.decode(String.self, forKey: .title)
        voteAverage = try? values.decode(Float.self, forKey: .voteAverage)
    }

    init(detail: CDMovieDetail) {
        self.id = Int(detail.id)
        self.title = detail.title
        self.voteAverage = detail.voteAverage
        self.posterPath = detail.thumbPath
    }
}
