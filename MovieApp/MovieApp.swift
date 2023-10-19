//
//  MovieApp.swift
//  MovieApp
//
//  Created by Aman Gupta on 18/10/23.
//

import SwiftUI

@main
struct MovieApp: App {
    var body: some Scene {
        WindowGroup {
            let router = Application.shared.assembler.resolver.resolve(AppRouterType.self)
            router?.displayMovieOptionsView()
        }
    }
}
