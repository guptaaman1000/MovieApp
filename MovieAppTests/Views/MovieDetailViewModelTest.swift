//
//  MovieDetailViewModelTest.swift
//  MovieApp
//
//  Created by Aman Gupta on 20/10/23.
//

import XCTest
import SwiftyMocky
import Combine
import Core
@testable import MovieApp

class MovieDetailViewModelTest: XCTestCase {
    
    private var model: MovieDetailViewModel!
    private var interactor: MovieInteractorTypeMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        interactor = MovieInteractorTypeMock()
        let mockResponse: MovieMetaData = try XCTUnwrap(getDataFromJson())
        model = MovieDetailViewModel(movieInteractor: interactor, metaData: mockResponse)
    }
    
    override func tearDown() {
        interactor = nil
        model = nil
        super.tearDown()
    }
    
    func testFetchMovieDetail_success() throws {
        
        // Given
        let mockResponse: MovieDetail = try XCTUnwrap(getDataFromJson())
        let returnValue = Just(mockResponse)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
        interactor.given(.getMovieDetail(id: .any, willReturn: returnValue))
        
        // When
        let exp = expectation(description: "Loading movie details")
        exp.isInverted = true
        model.fetchMovieDetail()
        waitForExpectations(timeout: 0.5)
        
        // Then
        let result = try XCTUnwrap(model.dataSource)
        XCTAssertEqual(result.id, 550)
    }
    
    func testFetchMovieDetail_failure() {
        
        // Given
        let returnValue = Fail<MovieDetail, NetworkError>(error: NetworkError.noContent)
            .eraseToAnyPublisher()
        interactor.given(.getMovieDetail(id: .any, willReturn: returnValue))
        
        // When
        let exp = expectation(description: "Loading movie details")
        exp.isInverted = true
        model.fetchMovieDetail()
        waitForExpectations(timeout: 0.5)

        // Then
        XCTAssertNil(model.dataSource)
    }
    
    func testHandleFavourite() throws {
        
        // Given
        model.dataSource = getDataFromJson()
        XCTAssertFalse(model.dataSource?.isFavourite ?? false)
        
        // When
        model.handleFavourite()
        
        // Then
        XCTAssertTrue(model.dataSource?.isFavourite ?? false)
    }
}
