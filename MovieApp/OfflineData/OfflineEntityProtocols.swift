//
//  OfflineEntityProtocols.swift
//  MovieApp
//
//  Created by Aman Gupta on 24/10/23.
//

import Foundation

protocol MovieDetailType {
    
    associatedtype GenreDataType: GenreType
    associatedtype LanguageDataType: LanguageType
    
    var budget: Int32 { get }
    var fullPath: String? { get }
    var id: Int32 { get }
    var isFavourite: Bool { get }
    var overview: String? { get }
    var releaseDate: String? { get }
    var revenue: Int32 { get }
    var runtime: Int32 { get }
    var thumbPath: String? { get }
    var title: String? { get }
    var voteAverage: Float { get }
    var genres: [GenreDataType]? { get }
    var spokenLanguages: [LanguageDataType]? { get }
}

protocol GenreType {
    var id: Int32 { get }
    var name: String? { get }
}

protocol LanguageType {
    var isoCode: String? { get }
    var name: String? { get }
}
