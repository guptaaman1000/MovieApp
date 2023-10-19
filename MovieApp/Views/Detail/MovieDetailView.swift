//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by Aman Gupta on 19/10/23.
//

import SwiftUI
import CachedAsyncImage

struct MovieDetailView: View {
    
    private let viewModel: MovieDetailViewModel
    
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            if let dataSource = viewModel.dataSource {
                CachedAsyncImage(
                    url: dataSource.posterPath ?? "",
                    placeholder: {
                        Image(systemName: "photo.fill")
                            .resizable()
                            .scaledToFill()
                            .edgesIgnoringSafeArea(.all)
                    },
                    image: {
                        Image(uiImage: $0)
                            .resizable()
                            .scaledToFill()
                            .edgesIgnoringSafeArea(.all)
                    }
                )
                Color.black
                    .opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    Button(action: {
                        viewModel.handleFavourite()
                    }) {
                        Image(systemName: "heart.fill")
                            .font(.system(size: 50))
                            .foregroundColor(viewModel.dataSource?.isFavourite ?? false ? .red : .white)
                    }
                    Spacer()
                }
            } else {
                Text("Loading...")
            }
        }
        .onAppear {
            viewModel.fetchMovieDetail()
        }
    }
}

//#Preview {
//    MovieDetailView()
//}
