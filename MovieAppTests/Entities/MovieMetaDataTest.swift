//
//  MovieMetaDataTest.swift
//  MovieAppTests
//
//  Created by Aman Gupta on 20/10/23.
//

import XCTest
@testable import MovieApp

class MovieMetaDataTest: XCTestCase {
    
    func testMovieMetaData_initDecoder() throws {
        
        // Given
        let result = try XCTUnwrap(getMovieMetaDataFromJson())
        
        // Then
        XCTAssertEqual(result.posterPath, "https://image.tmdb.org/t/p/w200/7PzJdsLGlR7oW4J0J5Xcd0pHGRg.png")
        XCTAssertEqual(result.id, 508)
        XCTAssertEqual(result.title, "Regency Enterprises")
        XCTAssertEqual(result.voteAverage, 7.5)
    }
    
    func testMovieMetaData_initDetail() {
        
        // Given
        let context = CoreDataManager.shared.newChildContext()
        let cdMovie = CDMovieDetail(context: context)
        cdMovie.id = 100
        cdMovie.title = "Mission Impossible"
        
        // When
        let result = MovieMetaData(detail: cdMovie)
        
        // Then
        XCTAssertEqual(result.id, 100)
        XCTAssertEqual(result.title, "Mission Impossible")
    }
    
    private  func getMovieMetaDataFromJson() -> MovieMetaData? {
        var response: MovieMetaData?
        if let file = Bundle(for: MovieListViewModelTest.self).url(forResource: "MovieMetaData", withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: file)
                response = try JSONDecoder().decode(MovieMetaData.self, from: jsonData)
            } catch {
                print(error.localizedDescription)
            }
        }
        return response
    }
}
