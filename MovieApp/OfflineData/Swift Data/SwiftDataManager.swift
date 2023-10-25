//
//  SwiftDataManager.swift
//  MovieApp
//
//  Created by Aman Gupta on 24/10/23.
//

import Foundation
import SwiftData

class SwiftDataManager {
    
    static let shared = SwiftDataManager()
    
    private var modelContainer: ModelContainer = {
        let schema = Schema([
            SDGenre.self, SDLanguage.self, SDMovieDetail.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    @MainActor
    var mainContext: ModelContext {
        modelContainer.mainContext
    }
    
    private init() { }
    
    func newContext() -> ModelContext {
        ModelContext(modelContainer)
    }
}
