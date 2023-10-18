//
//  CDLanguage.swift
//  MovieApp
//
//  Created by Aman Gupta on 28/07/21.
//  Copyright © 2021 Aman Gupta. All rights reserved.
//

import Foundation
import CoreData

class CDLanguage: NSManagedObject {

    static func create(languages: [Language]?, context: NSManagedObjectContext) -> NSSet {

        let languageSet = NSSet()

        for language in languages ?? [] {
            let cdLanguage = CDLanguage(context: context)
            cdLanguage.isoCode = language.isoCode
            cdLanguage.name = language.name
            languageSet.adding(cdLanguage)
        }

        return languageSet
    }
}
