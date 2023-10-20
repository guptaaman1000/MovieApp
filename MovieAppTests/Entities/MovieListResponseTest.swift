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
        let result: MovieListResponse = try XCTUnwrap(getDataFromJson())
        
        // Then
        XCTAssertEqual(result.movieList.count, 20)
        XCTAssertEqual(result.page, 1)
        XCTAssertEqual(result.totalPages, 33)
        XCTAssertEqual(result.totalResults, 649)
    }
    
    func testMovieListResponse_initMetaData() throws {
        
        // Given
        let metaData: [MovieMetaData] = [try XCTUnwrap(getDataFromJson())]

        // When
        let result = MovieListResponse(movieList: metaData)
        
        // Then
        XCTAssertEqual(result.movieList.count, 1)
        XCTAssertEqual(result.page, 1)
        XCTAssertEqual(result.totalPages, 1)
        XCTAssertEqual(result.totalResults, 1)
    }
}
