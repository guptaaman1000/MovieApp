//
//  CDLanguage.swift
//  MovieApp
//
//  Created by Aman Gupta on 17/10/23.
//

import Foundation
import CoreData

final class CDLanguage: NSManagedObject {

    static func create(languages: [Language]?, context: NSManagedObjectContext) -> NSSet {
        let languageSet = NSSet()
        context.performAndWait {
            for language in languages ?? [] {
                let cdLanguage = CDLanguage(context: context)
                cdLanguage.isoCode = language.isoCode
                cdLanguage.name = language.name
                languageSet.adding(cdLanguage)
            }
        }
        return languageSet
    }
}

extension CDLanguage: LanguageType { }
