//
//  SDLanguage.swift
//  MovieApp
//
//  Created by Aman Gupta on 24/10/23.
//

import Foundation
import SwiftData

@Model
final class SDLanguage: LanguageType {
    
    let isoCode: String?
    let name: String?
    
    init(language: Language) {
        self.isoCode = language.isoCode
        self.name = language.name
    }
}

extension SDLanguage {

    static func create(from languages: [Language]?) -> [SDLanguage]? {
        return languages?.map(SDLanguage.init)
    }
}
