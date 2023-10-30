//
//  MovieOptionsView.swift
//  MovieApp
//
//  Created by Aman Gupta on 19/10/23.
//

import SwiftUI
import SharedComponents

struct MovieOptionsView: View {
    
    private let viewModel: MovieOptionsViewModel
    @State private var selectedTab = 0
    
    init(viewModel: MovieOptionsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                CustomTabBar(selectedTab: $selectedTab, tab1: "Now Playing", tab2: "Favourite")
    
                TabView(selection: $selectedTab) {
                    NavigationStack {
                        viewModel.getMovieListView(type: .online)
                    }
                    .tag(0)
                    
                    NavigationStack {
                        viewModel.getMovieListView(type: .offline)
                    }
                    .tag(1)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
            .background(Color.black.edgesIgnoringSafeArea(.bottom))
        }
        .background(Color.black.edgesIgnoringSafeArea(.bottom))
    }
}

#Preview {
    let model = Application.shared.assembler.resolver.resolve(MovieOptionsViewModel.self)!
    return MovieOptionsView(viewModel: model)
}
