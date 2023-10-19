//
//  MovieItemView.swift
//  MovieApp
//
//  Created by Aman Gupta on 19/10/23.
//

import SwiftUI
import CachedAsyncImage

struct MovieItemView: View {
    
    private let item: MovieMetaData
    
    init(item: MovieMetaData) {
        self.item = item
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 8) {
                CachedAsyncImage(
                    url: item.posterPath ?? "",
                    placeholder: {
                        Rectangle()
                            .fill(Color.gray)
                            .frame(height: geometry.size.height * 0.6)
                            .cornerRadius(8)
                    },
                    image: {
                        Image(uiImage: $0)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: geometry.size.height * 0.6)
                            .cornerRadius(8)
                    }
                )
                Text(item.title ?? "")
                    .font(.headline)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                if let rating = item.voteAverage {
                    Text("\(rating, specifier: "%.1f")/\(10)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

//struct MovieItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieItemView()
//    }
//}
