//
//  AppRouterTypeMock.swift
//  MovieAppTests
//
//  Created by Aman Gupta on 29/10/23.
//

import XCTest
@testable import MovieApp

class AppRouterTypeMock: AppRouterType {
    
    enum MethodType: Hashable {
        
        case displayMovieOptionsView(willReturn: MovieOptionsView)
        case displayMovieList(of: Parameter<MovieType>, willReturn: MovieListView)
        case displayMovieDetail(metaData: Parameter<MovieMetaData>, type: Parameter<MovieType>, willReturn: MovieDetailView)
        
        static func == (lhs: MethodType, rhs: MethodType) -> Bool {
            switch (lhs, rhs) {
            case (.displayMovieOptionsView(_), .displayMovieOptionsView(_)):
                return true
            case (let .displayMovieList(type1, _), let .displayMovieList(type2, _)):
                return type1 == type2
            case (let .displayMovieDetail(metaData1, type1, _), let .displayMovieDetail(metaData2, type2, _)):
                return metaData1 == metaData2 && type1 == type2
            default:
                return false
            }
        }
        
        func hash(into hasher: inout Hasher) {
            switch self {
            case .displayMovieOptionsView(_):
                hasher.combine(1)
            case let .displayMovieList(type, _):
                hasher.combine(type)
            case let .displayMovieDetail(metaData, type, _):
                hasher.combine(metaData)
                hasher.combine(type)
            }
        }
    }

    private var returnValues = Set<MethodType>()
    
    func given(_ method: MethodType) {
        returnValues.insert(method)
    }
    
    func displayMovieOptionsView() -> MovieOptionsView {
        for methodType in returnValues {
            if case let .displayMovieOptionsView(willReturn) = methodType {
                return willReturn
            }
        }
        fatalError("Return value is missing")
    }
    
    func displayMovieList(of type: MovieType) -> MovieListView {
        for methodType in returnValues {
            if case let .displayMovieList(.value(data), willReturn) = methodType, data == type {
                return willReturn
            } else if case let .displayMovieList(.any, willReturn) = methodType {
                return willReturn
            }
        }
        fatalError("Return value is missing")
    }
    
    func displayMovieDetail(metaData: MovieMetaData, type: MovieType) -> MovieDetailView {
        for methodType in returnValues {
            if case let .displayMovieDetail(.value(data1), .value(data2), willReturn) = methodType,
                data1 == metaData,
                data2 == type {
                return willReturn
            } else if case let .displayMovieDetail(.value(data), .any, willReturn) = methodType, data == metaData {
                return willReturn
            } else if case let .displayMovieDetail(.any, .value(data), willReturn) = methodType, data == type {
                return willReturn
            } else if case let .displayMovieDetail(.any, .any, willReturn) = methodType {
                return willReturn
            }
        }
        fatalError("Return value is missing")
    }
}
