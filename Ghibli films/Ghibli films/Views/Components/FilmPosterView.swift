//
//  FilmPosterView.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 5/1/26.
//

import SwiftUI

struct FilmPosterView: View {
    let film: Film
    let image: UIImage?

    var body: some View {
        ZStack(alignment: .topTrailing) {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
            } else {
                ProgressView()
                    .frame(width: 80, height: 120)
            }

            // Visual indicators for watched/favorite
            HStack(spacing: 4) {
                if film.isWatched {
                    Image(systemName: "eye.fill")
                        .font(.caption2)
                        .foregroundStyle(.white)
                        .padding(4)
                        .background(.blue.opacity(0.8))
                        .clipShape(Circle())
                }
                if film.isFavorite {
                    Image(systemName: "heart.fill")
                        .font(.caption2)
                        .foregroundStyle(.white)
                        .padding(4)
                        .background(.red.opacity(0.8))
                        .clipShape(Circle())
                }
            }
            .padding(4)
        }
    }
}

#Preview {
    FilmPosterView(film: .mock, image: nil)
}
