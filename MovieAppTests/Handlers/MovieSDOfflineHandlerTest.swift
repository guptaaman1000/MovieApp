//
//  MovieSDOfflineHandlerTest.swift
//  MovieAppTests
//
//  Created by Aman Gupta on 09/11/23.
//

import XCTest
import Combine
import Core
@testable import MovieApp

class MovieSDOfflineHandlerTest: XCTestCase {
    
    private var handler: MovieSDOfflineHandler!
    private var dataManager: SwiftDataManager!
    private var subscription: AnyCancellable!
    
    override func setUp() {
        super.setUp()
        dataManager = SwiftDataManager(supportedEntities: [
            SDGenre.self, SDLanguage.self, SDMovieDetail.self
        ], isStoredInMemoryOnly: true)
        handler = MovieSDOfflineHandler(swiftDataManager: dataManager)
    }
    
    override func tearDown() {
        handler = nil
        dataManager = nil
        subscription = nil
        super.tearDown()
    }
    
    func testGetMovieList_success() throws {
        
        given {
            let detail: MovieDetail = try XCTUnwrap(getDataFromJson())
            let metaData: MovieMetaData = try XCTUnwrap(getDataFromJson())
            let context = dataManager.newContext()
            SDMovieDetail.add(detail, metaData, in: context)
            dataManager.save(context)
            
            when {
                let exp = expectation(description: "Fetching movies")
                var result: [MovieMetaData]?
                subscription = handler.getMovieList(page: 1).sink { _ in
                    exp.fulfill()
                } receiveValue: { response in
                    result = response.movieList
                }
                waitForExpectations(timeout: 0.5)
                
                then {
                    XCTAssertEqual(result?.count, 1)
                    XCTAssertEqual(result?.first?.id, 550)
                    XCTAssertEqual(result?.first?.title, "Fight Club")
                }
            }
        }
    }
    
    func testGetMovieList_failure() {
        
        when {
            let exp = expectation(description: "Fetching movies")
            var result: [MovieMetaData]?
            subscription = handler.getMovieList(page: 1).sink { _ in
                exp.fulfill()
            } receiveValue: { response in
                result = response.movieList
            }
            waitForExpectations(timeout: 0.5)
            
            then {
                XCTAssertEqual(result?.count, 0)
            }
        }
    }

    func testGetMovieDetail_success() throws {
        
        given {
            let detail: MovieDetail = try XCTUnwrap(getDataFromJson())
            let metaData: MovieMetaData = try XCTUnwrap(getDataFromJson())
            let context = dataManager.newContext()
            SDMovieDetail.add(detail, metaData, in: context)
            dataManager.save(context)
            
            when {
                let exp = expectation(description: "Fetching movie detail")
                var result: MovieDetail?
                subscription = handler.getMovieDetail(id: 550).sink { _ in
                    exp.fulfill()
                } receiveValue: { response in
                    result = response
                }
                waitForExpectations(timeout: 0.5)
                
                then {
                    XCTAssertNotNil(result)
                    XCTAssertEqual(result?.id, 550)
                    XCTAssertEqual(result?.title, "Fight Club")
                }
            }
        }
    }

    func testGetMovieDetail_failure() {
        
        when {
            let exp = expectation(description: "Fetching movie detail")
            var result: MovieDetail?
            subscription = handler.getMovieDetail(id: 550).sink { _ in
                exp.fulfill()
            } receiveValue: { response in
                result = response
            }
            waitForExpectations(timeout: 0.5)
            
            then {
                XCTAssertNil(result)
            }
        }
    }
}
