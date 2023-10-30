//
//  MovieHandlerTypeMock.swift
//  MovieAppTests
//
//  Created by Aman Gupta on 29/10/23.
//

import XCTest
import Combine
import Core
@testable import MovieApp

class MovieHandlerTypeMock: MovieHandlerType {

    enum MethodType: Hashable {
        
        case getMovieList(page: Parameter<Int>, willReturn: AnyPublisher<MovieListResponse, NetworkError>)
        case getMovieDetail(id: Parameter<Int>, willReturn: AnyPublisher<MovieDetail, NetworkError>)
        
        static func == (lhs: MethodType, rhs: MethodType) -> Bool {
            switch (lhs, rhs) {
            case (let .getMovieList(page1, _), let .getMovieList(page2, _)):
                return page1 == page2
            case (let .getMovieDetail(id1, _), let .getMovieDetail(id2, _)):
                return id1 == id2
            default:
                return false
            }
        }
        
        func hash(into hasher: inout Hasher) {
            switch self {
            case let .getMovieList(page, _):
                hasher.combine(page)
            case let .getMovieDetail(id, _):
                hasher.combine(id)
            }
        }
    }

    private var returnValues = Set<MethodType>()
    
    func given(_ method: MethodType) {
        returnValues.insert(method)
    }
    
    func getMovieList(page: Int) -> AnyPublisher<MovieListResponse, NetworkError> {
        for methodType in returnValues {
            if case let .getMovieList(.value(data), willReturn) = methodType, data == page {
                return willReturn
            } else if case let .getMovieList(.any, willReturn) = methodType {
                return willReturn
            }
        }
        fatalError("Return value is missing")
    }
    
    func getMovieDetail(id: Int) -> AnyPublisher<MovieDetail, NetworkError> {
        for methodType in returnValues {
            if case let .getMovieDetail(.value(data), willReturn) = methodType, data == id {
                return willReturn
            } else if case let .getMovieDetail(.any, willReturn) = methodType {
                return willReturn
            }
        }
        fatalError("Return value is missing")
    }
}
