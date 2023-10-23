//
//  SnapshotTestCase.swift
//  MovieAppTests
//
//  Created by Aman Gupta on 20/10/23.
//

import XCTest
import FBSnapshotTestCase
import SwiftUI
import Combine
import Core
@testable import MovieApp

class SnapshotTestCase: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        recordMode = false
    }
    
    func testMovieList() {
        
        given {
            let router = AppRouterTypeMock()
            let interactor = MovieInteractorTypeMock()
            let model = MovieListViewModel(movieInteractor: interactor,
                                           appRouter: router,
                                           movieType: .online)
            let mockResponse: MovieListResponse = try XCTUnwrap(getDataFromJson())
            let returnValue = Just(mockResponse)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
            interactor.given(.getMovieList(page: .any, willReturn: returnValue))
            
            when {
                let exp = expectation(description: "Loading movies")
                exp.isInverted = true
                model.fetchMovies()
                waitForExpectations(timeout: 0.5)
                
                then {
                    let movieView = MovieListView(viewModel: model)
                    let vc = UIHostingController(rootView: movieView)
                    let window = UIWindow(frame: UIScreen.main.bounds)
                    window.rootViewController = vc
                    window.makeKeyAndVisible()
                    let view = vc.view!
                    FBSnapshotVerifyView(view)
                }
            }
        }
    }
    
    func testMovieOptions() {
        
        given {
            let router = AppRouterTypeMock()
            let interactor = MovieInteractorTypeMock()
            let listModel = MovieListViewModel(movieInteractor: interactor,
                                               appRouter: router,
                                               movieType: .online)
            let optionsModel = MovieOptionsViewModel(appRouter: router)
            let mockResponse: MovieListResponse = try XCTUnwrap(getDataFromJson())
            let returnValue = Just(mockResponse)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
            interactor.given(.getMovieList(page: .any, willReturn: returnValue))
            router.given(.displayMovieList(of: .any, willReturn: MovieListView(viewModel: listModel)))
            
            then {
                let optionsView = MovieOptionsView(viewModel: optionsModel)
                let vc = UIHostingController(rootView: optionsView)
                let window = UIWindow(frame: UIScreen.main.bounds)
                window.rootViewController = vc
                window.makeKeyAndVisible()
                let view = vc.view!
                FBSnapshotVerifyView(view)
            }
        }
    }
    
    func testMovieDetail_withoutFavourite() {
        
        given {
            let interactor = MovieInteractorTypeMock()
            let mockMetaData: MovieMetaData = try XCTUnwrap(getDataFromJson())
            let model = MovieDetailViewModel(movieInteractor: interactor, metaData: mockMetaData)
            let mockResponse: MovieDetail = try XCTUnwrap(getDataFromJson())
            let returnValue = Just(mockResponse)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
            interactor.given(.getMovieDetail(id: .any, willReturn: returnValue))
            
            when {
                let exp = expectation(description: "Loading movie detail")
                exp.isInverted = true
                model.fetchMovieDetail()
                waitForExpectations(timeout: 0.5)
                
                then {
                    let movieDetailView = MovieDetailView(viewModel: model)
                    let vc = UIHostingController(rootView: movieDetailView)
                    let window = UIWindow(frame: UIScreen.main.bounds)
                    window.rootViewController = vc
                    window.makeKeyAndVisible()
                    let view = vc.view!
                    FBSnapshotVerifyView(view)
                }
            }
        }
    }
    
    func testMovieDetail_withFavourite() {
        
        given {
            let interactor = MovieInteractorTypeMock()
            let mockMetaData: MovieMetaData = try XCTUnwrap(getDataFromJson())
            let model = MovieDetailViewModel(movieInteractor: interactor, metaData: mockMetaData)
            let mockResponse: MovieDetail = try XCTUnwrap(getDataFromJson())
            let returnValue = Just(mockResponse)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
            interactor.given(.getMovieDetail(id: .any, willReturn: returnValue))
            
            when {
                let exp = expectation(description: "Loading movie detail")
                exp.isInverted = true
                model.fetchMovieDetail()
                waitForExpectations(timeout: 0.5)
                model.handleFavourite()
                
                then {
                    let movieDetailView = MovieDetailView(viewModel: model)
                    let vc = UIHostingController(rootView: movieDetailView)
                    let window = UIWindow(frame: UIScreen.main.bounds)
                    window.rootViewController = vc
                    window.makeKeyAndVisible()
                    let view = vc.view!
                    FBSnapshotVerifyView(view)
                }
            }
        }
    }
    
    func testMovieItemView() {
        
        given {
            let mockMetaData: MovieMetaData = try XCTUnwrap(getDataFromJson())
            
            then {
                let movieDetailView = MovieItemView(item: mockMetaData)
                    .background(Color.black)
                    .frame(width: 100, height: 220)
                let vc = UIHostingController(rootView: movieDetailView)
                let window = UIWindow(frame: UIScreen.main.bounds)
                window.rootViewController = vc
                window.makeKeyAndVisible()
                let view = vc.view!
                FBSnapshotVerifyView(view)
            }
        }
    }
}
