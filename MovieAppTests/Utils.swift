//
//  Utils.swift
//  MovieAppTests
//
//  Created by Aman Gupta on 20/10/23.
//

import Foundation
@testable import MovieApp

func getDataFromJson<T: Decodable>() -> T? {
    var response: T?
    if let file = Bundle(for: MovieDetailTest.self).url(forResource: String(describing: T.self), withExtension: "json") {
        do {
            let jsonData = try Data(contentsOf: file)
            response = try JSONDecoder().decode(T.self, from: jsonData)
        } catch {
            print(error.localizedDescription)
        }
    }
    return response
}
