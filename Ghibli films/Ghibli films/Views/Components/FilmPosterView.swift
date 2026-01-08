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
                    .posterStyle()
            } else {
                ProgressView()
                    .frame(width: 80, height: 120)
            }

            HStack(spacing: 4) {
                if film.isWatched {
                    Image(systemName: "eye.fill")
                        .badgeStyle(color: .blue)
                }
                if film.isFavorite {
                    Image(systemName: "heart.fill")
                        .badgeStyle(color: .red)
                }
            }
            .padding(4)
        }
    }
}

#Preview {
    FilmPosterView(film: .mock, image: nil)
}
