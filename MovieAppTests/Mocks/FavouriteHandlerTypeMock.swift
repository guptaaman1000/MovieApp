//
//  FavouriteHandlerTypeMock.swift
//  MovieAppTests
//
//  Created by Aman Gupta on 29/10/23.
//

import XCTest
@testable import MovieApp

extension MovieDetail: Hashable {
    
    public static func == (lhs: MovieDetail, rhs: MovieDetail) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

class FavouriteHandlerTypeMock: FavouriteHandlerType {
    
    enum MethodType: Hashable {
        
        case updateFavourite(detail: Parameter<MovieDetail>, willReturn: MovieDetail)
        
        static func == (lhs: MethodType, rhs: MethodType) -> Bool {
            switch (lhs, rhs) {
            case (let .updateFavourite(detail1, _), let .updateFavourite(detail2, _)):
                return detail1 == detail2
            }
        }
        
        func hash(into hasher: inout Hasher) {
            switch self {
            case let .updateFavourite(detail, _):
                hasher.combine(detail)
            }
        }
    }

    private var returnValues = Set<MethodType>()
    
    func given(_ method: MethodType) {
        returnValues.insert(method)
    }
    
    func handleFavourite(detail: MovieDetail, metaData: MovieMetaData) {
        
    }
    
    func updateFavourite(detail: MovieDetail) async -> MovieDetail {
        for methodType in returnValues {
            if case let .updateFavourite(.value(data), willReturn) = methodType, data == detail {
                return willReturn
            } else if case let .updateFavourite(.any, willReturn) = methodType {
                return willReturn
            }
        }
        fatalError("Return value is missing")
    }
}
