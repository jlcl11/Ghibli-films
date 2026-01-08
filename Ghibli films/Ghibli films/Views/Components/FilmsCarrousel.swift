//
//  FilmsCarrousel.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 5/1/26.
//

import SwiftUI

struct FilmsCarrousel: View {

    let featuredFilms: [Film]

    var body: some View {

        ScrollView(.horizontal) {
            LazyHStack(spacing: 12) {
                ForEach(featuredFilms) { film in
                    NavigationLink(value: film) {
                        FeaturedFilmCard(film: film)
                    }
                    .buttonStyle(.plain)
                }
            }
            .scrollTargetLayout()
        }
        .carouselScrollStyle()
        .clearListRowStyle()

    }
}

#Preview {
    FilmsCarrousel(featuredFilms: [.mock, .mock, .mock, .mock])
}
