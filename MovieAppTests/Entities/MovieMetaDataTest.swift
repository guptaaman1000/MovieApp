//
//  MovieMetaDataTest.swift
//  MovieAppTests
//
//  Created by Aman Gupta on 20/10/23.
//

import XCTest
import Core
@testable import MovieApp

class MovieMetaDataTest: XCTestCase {
    
    private var coreDataManager: CoreDataManager!
    
    override func setUp() {
        super.setUp()
        coreDataManager = CoreDataManager(dataModelName: "Movie", isStoredInMemoryOnly: true)
    }
    
    override func tearDown() {
        coreDataManager = nil
        super.tearDown()
    }

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
            let context = coreDataManager.newChildContext()
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
