//
//  FavouriteSDHandlerTest.swift
//  MovieAppTests
//
//  Created by Aman Gupta on 09/11/23.
//

import XCTest
import Combine
import Core
@testable import MovieApp

class FavouriteSDHandlerTest: XCTestCase {
    
    private var handler: FavouriteSDHandler!
    private var dataManager: SwiftDataManager!
    private var subscription: AnyCancellable!
    
    override func setUp() {
        super.setUp()
        dataManager = SwiftDataManager(supportedEntities: [
            SDGenre.self, SDLanguage.self, SDMovieDetail.self
        ], isStoredInMemoryOnly: true)
        handler = FavouriteSDHandler(swiftDataManager: dataManager)
    }
    
    override func tearDown() {
        handler = nil
        dataManager = nil
        subscription = nil
        super.tearDown()
    }
    
    @MainActor
    func testHandleFavourite_add_success() throws {
        
        given {
            let metaData: MovieMetaData = try XCTUnwrap(getDataFromJson())
            var detail: MovieDetail = try XCTUnwrap(getDataFromJson())
            detail.isFavourite = true
            
            when {
                let exp = expectation(description: "Handle favourites")
                exp.isInverted = true
                handler.handleFavourite(detail: detail, metaData: metaData)
                waitForExpectations(timeout: 0.5)
                
                then {
                    let result = dataManager.getMatchingEntities(SDMovieDetail.self)
                    XCTAssertEqual(result.count, 1)
                    XCTAssertEqual(result.first?.isFavourite, true)
                }
            }
        }
    }
    
    @MainActor
    func testHandleFavourite_add_failure() throws {
        
        given {
            let metaData: MovieMetaData = try XCTUnwrap(getDataFromJson())
            var detail: MovieDetail = try XCTUnwrap(getDataFromJson())
            detail.isFavourite = false
            
            when {
                let exp = expectation(description: "Handle favourites")
                exp.isInverted = true
                handler.handleFavourite(detail: detail, metaData: metaData)
                waitForExpectations(timeout: 0.5)
                
                then {
                    let result = dataManager.getMatchingEntities(SDMovieDetail.self)
                    XCTAssertEqual(result.count, 0)
                }
            }
        }
    }

    @MainActor
    func testHandleFavourite_delete_success() throws {
        
        given {
            let metaData: MovieMetaData = try XCTUnwrap(getDataFromJson())
            var detail: MovieDetail = try XCTUnwrap(getDataFromJson())
            let context = dataManager.newContext()
            SDMovieDetail.add(detail, metaData, in: context)
            dataManager.save(context)
            detail.isFavourite = false
            
            when {
                let exp = expectation(description: "Handle favourites")
                exp.isInverted = true
                handler.handleFavourite(detail: detail, metaData: metaData)
                waitForExpectations(timeout: 0.5)
                
                then {
                    let result = dataManager.getMatchingEntities(SDMovieDetail.self)
                    XCTAssertEqual(result.count, 0)
                }
            }
        }
    }
    
    @MainActor
    func testHandleFavourite_delete_failure() throws {
        
        given {
            let metaData: MovieMetaData = try XCTUnwrap(getDataFromJson())
            var detail: MovieDetail = try XCTUnwrap(getDataFromJson())
            let context = dataManager.newContext()
            SDMovieDetail.add(detail, metaData, in: context)
            dataManager.save(context)
            detail.isFavourite = true
            
            when {
                let exp = expectation(description: "Handle favourites")
                exp.isInverted = true
                handler.handleFavourite(detail: detail, metaData: metaData)
                waitForExpectations(timeout: 0.5)
                
                then {
                    let result = dataManager.getMatchingEntities(SDMovieDetail.self)
                    XCTAssertEqual(result.count, 1)
                }
            }
        }
    }
    
    @MainActor
    func testUpdateFavourite_success() throws {
        
        given {
            let metaData: MovieMetaData = try XCTUnwrap(getDataFromJson())
            let detail: MovieDetail = try XCTUnwrap(getDataFromJson())
            let context = dataManager.newContext()
            SDMovieDetail.add(detail, metaData, in: context)
            dataManager.save(context)
            
            when {
                let result = handler.updateFavourite(detail: detail)
                
                then {
                    XCTAssertTrue(result.isFavourite)
                }
            }
        }
    }
    
    @MainActor
    func testUpdateFavourite_failure() throws {
        
        given {
            let detail: MovieDetail = try XCTUnwrap(getDataFromJson())
            
            when {
                let result = handler.updateFavourite(detail: detail)
                
                then {
                    XCTAssertFalse(result.isFavourite)
                }
            }
        }
    }

}
