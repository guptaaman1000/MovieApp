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
            let handler = MovieHandlerTypeMock()
            let model = MovieListViewModel(movieHandler: handler,
                                           appRouter: router,
                                           movieType: .online)
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
            let handler = MovieHandlerTypeMock()
            let listModel = MovieListViewModel(movieHandler: handler,
                                               appRouter: router,
                                               movieType: .online)
            let optionsModel = MovieOptionsViewModel(appRouter: router)
            let mockResponse: MovieListResponse = try XCTUnwrap(getDataFromJson())
            let returnValue = Just(mockResponse)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
            handler.given(.getMovieList(page: .any, willReturn: returnValue))
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
            let movieHandler = MovieHandlerTypeMock()
            let favouriteHandler = FavouriteHandlerTypeMock()
            let mockMetaData: MovieMetaData = try XCTUnwrap(getDataFromJson())
            let model = MovieDetailViewModel(movieHandler: movieHandler,
                                             favouriteHandler: favouriteHandler,
                                             metaData: mockMetaData)
            let mockResponse: MovieDetail = try XCTUnwrap(getDataFromJson())
            let returnValue = Just(mockResponse)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
            movieHandler.given(.getMovieDetail(id: .any, willReturn: returnValue))
            favouriteHandler.given(.updateFavourite(detail: .any, willReturn: mockResponse))
            
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
            let movieHandler = MovieHandlerTypeMock()
            let favouriteHandler = FavouriteHandlerTypeMock()
            let mockMetaData: MovieMetaData = try XCTUnwrap(getDataFromJson())
            let model = MovieDetailViewModel(movieHandler: movieHandler,
                                             favouriteHandler: favouriteHandler,
                                             metaData: mockMetaData)
            let mockResponse: MovieDetail = try XCTUnwrap(getDataFromJson())
            let returnValue = Just(mockResponse)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
            movieHandler.given(.getMovieDetail(id: .any, willReturn: returnValue))
            favouriteHandler.given(.updateFavourite(detail: .any, willReturn: mockResponse))
            
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
