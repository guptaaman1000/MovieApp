//
//  Application.swift
//  MovieApp
//
//  Created by Aman Gupta on 19/10/23.
//

import Foundation
import Swinject
import CachedAsyncImage

final class Application {
    
    static let shared = Application()
    let assembler: Assembler
    
    private init() {
        assembler = Assembler([AppAssembly()])
        TemporaryImageCache.shared.setCacheLimit(
            countLimit: 1000, // 1000 items
            totalCostLimit: 1024 * 1024 * 200 // 200 MB
        )
    }
}
