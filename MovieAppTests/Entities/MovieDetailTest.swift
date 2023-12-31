//
//  MovieDetailTest.swift
//  MovieAppTests
//
//  Created by Aman Gupta on 20/10/23.
//

import XCTest
import Core
@testable import MovieApp

class MovieDetailTest: XCTestCase {
    
    private var coreDataManager: CoreDataManager!
    
    override func setUp() {
        super.setUp()
        coreDataManager = CoreDataManager(dataModelName: "Movie", isStoredInMemoryOnly: true)
    }
    
    override func tearDown() {
        coreDataManager = nil
        super.tearDown()
    }

    func testMovieDetail_initDecoder() {
        
        given {
            let result: MovieDetail = try XCTUnwrap(getDataFromJson())
            
            then {
                XCTAssertEqual(result.id, 550)
                XCTAssertEqual(result.title, "Fight Club")
                XCTAssertEqual(result.genres?.count, 1)
                XCTAssertEqual(result.spokenLanguages?.count, 1)
            }
        }
    }
    
    func testMovieDetail_initDetail() {
        
        given {
            let context = coreDataManager.newChildContext()
            let cdMovie = CDMovieDetail(context: context)
            cdMovie.id = 100
            cdMovie.title = "Mission Impossible"
            let cdGenre = CDGenre(context: context)
            cdGenre.id = 200
            cdGenre.name = "Comedy"
            let cdLanguage = CDLanguage(context: context)
            cdLanguage.isoCode = "en_US"
            cdLanguage.name = "English"
            cdMovie.genresSet = NSSet(array: [cdGenre])
            cdMovie.spokenLanguagesSet = NSSet(array: [cdLanguage])
            
            when {
                let result = MovieDetail(detail: cdMovie)
                
                then {
                    XCTAssertEqual(result.id, 100)
                    XCTAssertEqual(result.title, "Mission Impossible")
                }
            }
        }
    }
    
    func testGenre_initDetail() {
        
        given {
            let context = coreDataManager.newChildContext()
            let cdGenre = CDGenre(context: context)
            cdGenre.id = 200
            cdGenre.name = "Comedy"
            
            when {
                let result = Genre(detail: cdGenre)
                
                then {
                    XCTAssertEqual(result.id, 200)
                    XCTAssertEqual(result.name, "Comedy")
                }
            }
        }
    }
    
    func testLanguage_initDetail_isoCodeNotNil() {
        
        given {
            let context = coreDataManager.newChildContext()
            let cdLanguage = CDLanguage(context: context)
            cdLanguage.isoCode = "en_US"
            cdLanguage.name = "English"
            
            when {
                let result = Language(detail: cdLanguage)
                
                then {
                    XCTAssertEqual(result.isoCode, "en_US")
                    XCTAssertEqual(result.name, "English")
                }
            }
        }
    }
    
    func testLanguage_initDetail_isoCodeNil() {
        
        given {
            let context = coreDataManager.newChildContext()
            let cdLanguage = CDLanguage(context: context)
            cdLanguage.name = "English"
            
            when {
                let result = Language(detail: cdLanguage)
                
                then {
                    XCTAssertEqual(result.isoCode, "")
                    XCTAssertEqual(result.name, "English")
                }
            }
        }
    }
}
