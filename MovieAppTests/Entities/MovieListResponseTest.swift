//
//  MovieListResponseTest.swift
//  MovieAppTests
//
//  Created by Aman Gupta on 20/10/23.
//

import XCTest
@testable import MovieApp

class MovieListResponseTest: XCTestCase {
    
    func testMovieListResponse_initDecoder() {
        
        given {
            let result: MovieListResponse = try XCTUnwrap(getDataFromJson())
            
            then {
                XCTAssertEqual(result.movieList.count, 20)
                XCTAssertEqual(result.page, 1)
                XCTAssertEqual(result.totalPages, 33)
                XCTAssertEqual(result.totalResults, 649)
            }
        }
    }
    
    func testMovieListResponse_initMetaData() {
        
        given {
            let metaData: [MovieMetaData] = [try XCTUnwrap(getDataFromJson())]
            
            when {
                let result = MovieListResponse(movieList: metaData)
                
                then {
                    XCTAssertEqual(result.movieList.count, 1)
                    XCTAssertEqual(result.page, 1)
                    XCTAssertEqual(result.totalPages, 1)
                    XCTAssertEqual(result.totalResults, 1)
                }
            }
        }
    }
}
