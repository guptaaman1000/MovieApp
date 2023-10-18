//
//  MovieListResponse.swift
//  MovieApp
//
//  Created by Aman Gupta on 28/07/21.
//  Copyright © 2021 Aman Gupta. All rights reserved.
//

import Foundation

struct MovieListResponse: Decodable {
    
    let totalResults: Int
    let totalPages: Int
    let page: Int
    let movieList: [MovieMetaData]
    
    enum CodingKeys: String, CodingKey {
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case page = "page"
        case movieList = "results"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        totalResults = try values.decode(Int.self, forKey: .totalResults)
        totalPages = try values.decode(Int.self, forKey: .totalPages)
        page = try values.decode(Int.self, forKey: .page)
        movieList = try values.decode([MovieMetaData].self, forKey: .movieList)
    }

    init(movieList: [MovieMetaData]) {
        self.totalResults = movieList.count
        self.totalPages = 1
        self.page = 1
        self.movieList = movieList
    }
}
