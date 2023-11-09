//
//  FavouriteCDHandlerTest.swift
//  MovieAppTests
//
//  Created by Aman Gupta on 09/11/23.
//

import XCTest
import Combine
import Core
@testable import MovieApp

class FavouriteCDHandlerTest: XCTestCase {
    
    private var handler: FavouriteCDHandler!
    private var dataManager: CoreDataManager!
    private var subscription: AnyCancellable!
    
    override func setUp() {
        super.setUp()
        dataManager = CoreDataManager(dataModelName: "Movie", isStoredInMemoryOnly: true)
        handler = FavouriteCDHandler(coreDataManager: dataManager)
    }
    
    override func tearDown() {
        handler = nil
        dataManager = nil
        subscription = nil
        super.tearDown()
    }
    
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
                    let result = dataManager.getMatchingEntities(CDMovieDetail.self)
                    XCTAssertEqual(result.count, 1)
                    XCTAssertEqual(result.first?.isFavourite, true)
                }
            }
        }
    }
    
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
                    let result = dataManager.getMatchingEntities(CDMovieDetail.self)
                    XCTAssertEqual(result.count, 0)
                }
            }
        }
    }

    func testHandleFavourite_delete_success() throws {
        
        given {
            let metaData: MovieMetaData = try XCTUnwrap(getDataFromJson())
            var detail: MovieDetail = try XCTUnwrap(getDataFromJson())
            let context = dataManager.newChildContext()
            CDMovieDetail.add(detail, metaData, in: context)
            _ = dataManager.saveAndWait(in: context)
            detail.isFavourite = false
            
            when {
                let exp = expectation(description: "Handle favourites")
                exp.isInverted = true
                handler.handleFavourite(detail: detail, metaData: metaData)
                waitForExpectations(timeout: 0.5)
                
                then {
                    let result = dataManager.getMatchingEntities(CDMovieDetail.self)
                    XCTAssertEqual(result.count, 0)
                }
            }
        }
    }
    
    func testHandleFavourite_delete_failure() throws {
        
        given {
            let metaData: MovieMetaData = try XCTUnwrap(getDataFromJson())
            var detail: MovieDetail = try XCTUnwrap(getDataFromJson())
            let context = dataManager.newChildContext()
            CDMovieDetail.add(detail, metaData, in: context)
            _ = dataManager.saveAndWait(in: context)
            detail.isFavourite = true
            
            when {
                let exp = expectation(description: "Handle favourites")
                exp.isInverted = true
                handler.handleFavourite(detail: detail, metaData: metaData)
                waitForExpectations(timeout: 0.5)
                
                then {
                    let result = dataManager.getMatchingEntities(CDMovieDetail.self)
                    XCTAssertEqual(result.count, 1)
                }
            }
        }
    }
    
    func testUpdateFavourite_success() throws {
        
        given {
            let metaData: MovieMetaData = try XCTUnwrap(getDataFromJson())
            let detail: MovieDetail = try XCTUnwrap(getDataFromJson())
            let context = dataManager.newChildContext()
            CDMovieDetail.add(detail, metaData, in: context)
            dataManager.save(context)
            
            when {
                let exp = expectation(description: "Update favourites")
                Task {
                    let result = await handler.updateFavourite(detail: detail)
                    XCTAssertTrue(result.isFavourite)
                    exp.fulfill()
                }
                waitForExpectations(timeout: 0.5)
            }
        }
    }
    
    func testUpdateFavourite_failure() throws {
        
        given {
            let detail: MovieDetail = try XCTUnwrap(getDataFromJson())
            
            when {
                let exp = expectation(description: "Update favourites")
                Task {
                    let result = await handler.updateFavourite(detail: detail)
                    XCTAssertFalse(result.isFavourite)
                    exp.fulfill()
                }
                waitForExpectations(timeout: 0.5)
            }
        }
    }
}
