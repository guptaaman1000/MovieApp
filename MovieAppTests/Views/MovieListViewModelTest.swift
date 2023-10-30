//
//  MovieListViewModelTest.swift
//  MovieApp
//
//  Created by Aman Gupta on 20/10/23.
//

import XCTest
import Combine
import Core
@testable import MovieApp

class MovieListViewModelTest: XCTestCase {
    
    private var model: MovieListViewModel!
    private var router : AppRouterTypeMock!
    private var handler: MovieHandlerTypeMock!
    
    override func setUp() {
        super.setUp()
        router = AppRouterTypeMock()
        handler = MovieHandlerTypeMock()
        model = MovieListViewModel(movieHandler: handler, appRouter: router, movieType: .online)
    }
    
    override func tearDown() {
        handler = nil
        router = nil
        model = nil
        super.tearDown()
    }
    
    func testFetchMovieList_success() {
        
        given {
            let mockResponse: MovieListResponse = try XCTUnwrap(getDataFromJson())
            let returnValue = Just(mockResponse)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
            handler.given(.getMovieList(page: .any, willReturn: returnValue))
            
            when {
                let exp = expectation(description: "Loading movies")
                exp.isInverted = true
                model.fetchMovies()
                waitForExpectations(timeout: 0.5)
                
                then {
                    XCTAssertFalse(model.dataSource.isEmpty)
                    XCTAssertEqual(model.dataSource.count, 20)
                }
            }
        }
    }
    
    func testFetchMovieList_failure() {
        
        given {
            let returnValue = Fail<MovieListResponse, NetworkError>(error: NetworkError.noContent)
                .eraseToAnyPublisher()
            handler.given(.getMovieList(page: .any, willReturn: returnValue))
            
            when {
                let exp = expectation(description: "Loading movies")
                exp.isInverted = true
                model.fetchMovies()
                waitForExpectations(timeout: 0.5)
                
                then {
                    XCTAssertTrue(model.dataSource.isEmpty)
                    XCTAssertEqual(model.dataSource.count, 0)
                }
            }
        }
    }
}
