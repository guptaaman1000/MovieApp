//
//  MovieListResponseTest.swift
//  MovieAppTests
//
//  Created by Aman Gupta on 20/10/23.
//

import XCTest
@testable import MovieApp

class MovieListResponseTest: XCTestCase {
    
    func testMovieListResponse_initDecoder() throws {
        
        // Given
        let result = try XCTUnwrap(getMovieListResponseFromJson())
        
        // Then
        XCTAssertEqual(result.movieList.count, 20)
        XCTAssertEqual(result.page, 1)
        XCTAssertEqual(result.totalPages, 33)
        XCTAssertEqual(result.totalResults, 649)
    }
    
    func testMovieListResponse_initMetaData() throws {
        
        // Given
        let metaData = [try XCTUnwrap(getMovieMetaDataFromJson())]

        // When
        let result = MovieListResponse(movieList: metaData)
        
        // Then
        XCTAssertEqual(result.movieList.count, 1)
        XCTAssertEqual(result.page, 1)
        XCTAssertEqual(result.totalPages, 1)
        XCTAssertEqual(result.totalResults, 1)
    }
    
    private  func getMovieListResponseFromJson() -> MovieListResponse? {
        var response: MovieListResponse?
        if let file = Bundle(for: MovieListViewModelTest.self).url(forResource: "MovieListResponse", withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: file)
                response = try JSONDecoder().decode(MovieListResponse.self, from: jsonData)
            } catch {
                print(error.localizedDescription)
            }
        }
        return response
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
