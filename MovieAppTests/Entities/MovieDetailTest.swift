//
//  MovieDetailTest.swift
//  MovieAppTests
//
//  Created by Aman Gupta on 20/10/23.
//

import XCTest
@testable import MovieApp

class MovieDetailTest: XCTestCase {
    
    func testMovieDetail_initDecoder() throws {
        
        // Given
        let result = try XCTUnwrap(getMovieDetailFromJson())
        
        // Then
        XCTAssertEqual(result.id, 550)
        XCTAssertEqual(result.title, "Fight Club")
        XCTAssertEqual(result.genres?.count, 1)
        XCTAssertEqual(result.spokenLanguages?.count, 1)
    }
    
    func testMovieDetail_initDetail() {
                
        // Given
        let context = CoreDataManager.shared.newChildContext()
        let cdMovie = CDMovieDetail(context: context)
        cdMovie.id = 100
        cdMovie.title = "Mission Impossible"
        
        // When
        let result = MovieDetail(detail: cdMovie)
        
        // Then
        XCTAssertEqual(result.id, 100)
        XCTAssertEqual(result.title, "Mission Impossible")
    }

    func testGenre_initDetail() {
        
        // Given
        let context = CoreDataManager.shared.newChildContext()
        let cdGenre = CDGenre(context: context)
        cdGenre.id = 200
        cdGenre.name = "Comedy"
        
        // When
        let result = Genre(detail: cdGenre)
        
        // Then
        XCTAssertEqual(result.id, 200)
        XCTAssertEqual(result.name, "Comedy")
    }
    
    func testLanguage_initDetail() {
        
        // Given
        let context = CoreDataManager.shared.newChildContext()
        let cdLanguage = CDLanguage(context: context)
        cdLanguage.isoCode = "en_US"
        cdLanguage.name = "English"
        
        // When
        let result = Language(detail: cdLanguage)
        
        // Then
        XCTAssertEqual(result.isoCode, "en_US")
        XCTAssertEqual(result.name, "English")
    }

    private  func getMovieDetailFromJson() -> MovieDetail? {
        var response: MovieDetail?
        if let file = Bundle(for: MovieListViewModelTest.self).url(forResource: "MovieDetail", withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: file)
                response = try JSONDecoder().decode(MovieDetail.self, from: jsonData)
            } catch {
                print(error.localizedDescription)
            }
        }
        return response
    }
}
