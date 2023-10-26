//
//  MovieItemView.swift
//  MovieApp
//
//  Created by Aman Gupta on 19/10/23.
//

import SwiftUI
import CachedAsyncImage
import Core

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
//        let context = CoreDataManager.shared.newChildContext()
//        let cdMovie = CDMovieDetail(context: context)
//        cdMovie.id = 968051
//        cdMovie.title = "The Nun II"
//        cdMovie.voteAverage = 6.98899984
//        cdMovie.thumbPath = "\(BaseUrlType.imageUrl.rawValue)/w200/5gzzkR7y3hnY8AD1wXjCnVlHba5.jpg"
//        let metaData = MovieMetaData(detail: cdMovie)
//        return MovieItemView(item: metaData)
//            .background(Color.black)
//            .frame(width: 130, height: 220)
//    }
//}
