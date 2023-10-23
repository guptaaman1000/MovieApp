//
//  MovieMetaDataTest.swift
//  MovieAppTests
//
//  Created by Aman Gupta on 20/10/23.
//

import XCTest
@testable import MovieApp

class MovieMetaDataTest: XCTestCase {
    
    func testMovieMetaData_initDecoder() {
        
        given {
            let result: MovieMetaData = try XCTUnwrap(getDataFromJson())
            
            then {
                XCTAssertEqual(result.posterPath, "https://image.tmdb.org/t/p/w200/7PzJdsLGlR7oW4J0J5Xcd0pHGRg.png")
                XCTAssertEqual(result.id, 508)
                XCTAssertEqual(result.title, "Regency Enterprises")
                XCTAssertEqual(result.voteAverage, 7.5)
            }
        }
    }
    
    func testMovieMetaData_initDetail() {
        
        given {
            let context = CoreDataManager.shared.newChildContext()
            let cdMovie = CDMovieDetail(context: context)
            cdMovie.id = 100
            cdMovie.title = "Mission Impossible"
            
            when {
                let result = MovieMetaData(detail: cdMovie)
                
                then {
                    XCTAssertEqual(result.id, 100)
                    XCTAssertEqual(result.title, "Mission Impossible")
                }
            }
        }
    }
}
