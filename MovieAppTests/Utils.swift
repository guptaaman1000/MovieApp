//
//  Utils.swift
//  MovieAppTests
//
//  Created by Aman Gupta on 20/10/23.
//

import Foundation
import os.log
import XCTest
@testable import MovieApp

func given(_ description: String = "", block: () throws -> Void) {
    os_log("Given %{public}@", description)
    do {
        _ = try XCTContext.runActivity(named: "Given " + description, block: { _ in try block()})
    } catch {
        os_log("Given error %{public}@", error.localizedDescription)
    }
}

func when(_ description: String = "", block: () throws -> Void) {
    os_log("When %{public}@", description)
    do {
        _ = try XCTContext.runActivity(named: "When " + description, block: { _ in try block()})
    } catch {
        os_log("When error %{public}@", error.localizedDescription)
    }
}

func then(_ description: String = "", block: () throws -> Void) {
    os_log("Then %{public}@", description)
    do {
        _ = try XCTContext.runActivity(named: "Then " + description, block: { _ in try block()})
    } catch {
        os_log("Then error %{public}@", error.localizedDescription)
    }
}

func getDataFromJson<T: Decodable>() -> T? {
    var response: T?
    if let file = Bundle(for: MovieDetailTest.self).url(forResource: String(describing: T.self), withExtension: "json") {
        do {
            let jsonData = try Data(contentsOf: file)
            response = try JSONDecoder().decode(T.self, from: jsonData)
        } catch {
            print(error.localizedDescription)
        }
    }
    return response
}

enum Parameter<ValueType: Hashable>: Hashable {
    
    case value(ValueType)
    case any
    
    static func == (lhs: Parameter<ValueType>, rhs: Parameter<ValueType>) -> Bool {
        switch (lhs, rhs) {
        case (let .value(data1), let .value(data2)):
            return data1 == data2
        case (.any, .any):
            return true
        default:
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case let .value(data):
            hasher.combine(data)
        case .any:
            hasher.combine(1)
        }
    }
}
