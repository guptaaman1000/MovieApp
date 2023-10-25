//
//  CDGenre.swift
//  MovieApp
//
//  Created by Aman Gupta on 17/10/23.
//

import Foundation
import CoreData

class CDGenre: NSManagedObject {

    static func create(genres: [Genre]?, context: NSManagedObjectContext) -> NSSet {

        let genreSet = NSSet()

        for genre in genres ?? [] {
            let cdGenre = CDGenre(context: context)
            cdGenre.id = Int32(genre.id)
            cdGenre.name = genre.name
            genreSet.adding(cdGenre)
        }

        return genreSet
    }
}

extension CDGenre: GenreType { }
