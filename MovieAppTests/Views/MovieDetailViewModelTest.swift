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
        let mockResponse = try XCTUnwrap(getMovieMetaDataFromJson())
        model = MovieDetailViewModel(movieInteractor: interactor, metaData: mockResponse)
    }
    
    override func tearDown() {
        interactor = nil
        model = nil
        super.tearDown()
    }
    
    func testFetchMovieDetail_success() throws {
        
        // Given
        let mockResponse = try XCTUnwrap(getMovieDetailFromJson())
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
        model.dataSource = getMovieDetailFromJson()
        XCTAssertFalse(model.dataSource?.isFavourite ?? false)
        
        // When
        model.handleFavourite()
        
        // Then
        XCTAssertTrue(model.dataSource?.isFavourite ?? false)
    }
    
    private  func getMovieDetailFromJson() -> MovieDetail? {
        var response: MovieDetail?
        if let file = Bundle(for: MovieListViewModelTest.self).url(forResource: "MovieDetail", withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: file)
                response = try JSONDecoder().decode(MovieDetail.self, from: jsonData)
            } catch {
                print(error.localizedDescription)
            }
        }
        return response
    }
    
    private  func getMovieMetaDataFromJson() -> MovieMetaData? {
        var response: MovieMetaData?
        if let file = Bundle(for: MovieListViewModelTest.self).url(forResource: "MovieMetaData", withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: file)
                response = try JSONDecoder().decode(MovieMetaData.self, from: jsonData)
            } catch {
                print(error.localizedDescription)
            }
        }
        return response
    }
}
