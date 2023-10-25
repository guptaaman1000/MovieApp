//
//  SDGenre.swift
//  MovieApp
//
//  Created by Aman Gupta on 24/10/23.
//

import Foundation
import SwiftData

@Model
final class SDGenre: GenreType {
    
    let id: Int32
    let name: String?
    
    init(genre: Genre) {
        self.id = Int32(genre.id)
        self.name = genre.name
    }
}

extension SDGenre {

    static func create(from genres: [Genre]?) -> [SDGenre]? {
        return genres?.map(SDGenre.init)
    }
}
