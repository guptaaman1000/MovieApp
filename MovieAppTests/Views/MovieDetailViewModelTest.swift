//
//  MovieDetailViewModelTest.swift
//  MovieApp
//
//  Created by Aman Gupta on 20/10/23.
//

import XCTest
import Combine
import Core
@testable import MovieApp

class MovieDetailViewModelTest: XCTestCase {
    
    private var model: MovieDetailViewModel!
    private var movieHandler: MovieHandlerTypeMock!
    private var favouriteHandler: FavouriteHandlerTypeMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        movieHandler = MovieHandlerTypeMock()
        favouriteHandler = FavouriteHandlerTypeMock()
        let mockResponse: MovieMetaData = try XCTUnwrap(getDataFromJson())
        model = MovieDetailViewModel(movieHandler: movieHandler, favouriteHandler: favouriteHandler, metaData: mockResponse)
    }
    
    override func tearDown() {
        movieHandler = nil
        favouriteHandler = nil
        model = nil
        super.tearDown()
    }
    
    func testFetchMovieDetail_success() {
        
        given {
            let mockResponse: MovieDetail = try XCTUnwrap(getDataFromJson())
            let returnValue = Just(mockResponse)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
            movieHandler.given(.getMovieDetail(id: .any, willReturn: returnValue))
            favouriteHandler.given(.updateFavourite(detail: .any, willReturn: mockResponse))
            
            when {
                let exp = expectation(description: "Loading movie details")
                exp.isInverted = true
                model.fetchMovieDetail()
                waitForExpectations(timeout: 0.5)
                
                then {
                    let result = try XCTUnwrap(model.dataSource)
                    XCTAssertEqual(result.id, 550)
                }
            }
        }
    }
    
    func testFetchMovieDetail_failure() {
        
        given {
            let mockResponse: MovieDetail = try XCTUnwrap(getDataFromJson())
            let returnValue = Fail<MovieDetail, NetworkError>(error: NetworkError.noContent)
                .eraseToAnyPublisher()
            movieHandler.given(.getMovieDetail(id: .any, willReturn: returnValue))
            favouriteHandler.given(.updateFavourite(detail: .any, willReturn: mockResponse))
            
            when {
                let exp = expectation(description: "Loading movie details")
                exp.isInverted = true
                model.fetchMovieDetail()
                waitForExpectations(timeout: 0.5)
                
                then {
                    XCTAssertNil(model.dataSource)
                }
            }
        }
    }
    
    func testHandleFavourite() {
        
        given {
            model.dataSource = getDataFromJson()
            XCTAssertFalse(model.dataSource?.isFavourite ?? false)
            
            when {
                model.handleFavourite()
                
                then {
                    XCTAssertTrue(model.dataSource?.isFavourite ?? false)
                }
            }
        }
    }
}
