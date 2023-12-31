//
//  MovieListView.swift
//  MovieApp
//
//  Created by Aman Gupta on 19/10/23.
//

import SwiftUI
import SharedComponents

struct MovieListView: View {
    
    private var viewModel: MovieListViewModel
    private let items = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(viewModel: MovieListViewModel) {
        self.viewModel = viewModel
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5, execute: {
            viewModel.fetchMovies()
        })
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: items, spacing: 10) {
                ForEach(viewModel.dataSource.indices, id:\.self) { index in
                    let item = viewModel.dataSource[index]
                    NavigationLink {
                        NavigationLazyView(viewModel.getMovieDetailView(item: item))
                    } label: {
                        MovieItemView(item: item).frame(height: 220)
                    }
                    .onAppear {
                        // Fetch next set of movies when user scrolls to bottom
                        if item == viewModel.dataSource.last &&
                            viewModel.movieType == .online {
                            viewModel.fetchMovies()
                        }
                    }
                }
            }
            .padding()
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .onAppear {
            if viewModel.movieType == .offline{
                viewModel.fetchMovies()
            }
        }
    }
}

#Preview {
    let model = Application.shared.assembler.resolver.resolve(MovieListViewModel.self, argument: MovieType.online)!
    return MovieListView(viewModel: model)
}
