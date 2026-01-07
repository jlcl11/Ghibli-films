//
//  FilmsGridView.swift
//  EstudioGhibli
//
//  Created by Claude Code on 18/12/25.
//

import SwiftUI

struct FilmsGridView: View {
    let films: [Film]
    let title: String
    let emptyStateIcon: String
    let emptyStateMessage: String

    var body: some View {
        ScrollView {
            if !films.isEmpty {
                LazyVGrid(
                    columns: [
                        GridItem(.adaptive(minimum: 100, maximum: 180), spacing: 10)
                    ],
                    spacing: 20
                ) {
                    ForEach(films) { film in
                        NavigationLink(destination: FilmDetail(film: film))  {
                            CachedFilmCard(film: film)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            } else {
                ContentUnavailableView(
                    title,
                    systemImage: emptyStateIcon,
                    description: Text(emptyStateMessage)
                )
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
      
    }
}

#Preview {
    NavigationStack {
        FilmsGridView(
            films: [.mock],
            title: "Favorite Films",
            emptyStateIcon: "heart.slash",
            emptyStateMessage: "Add films to favorites to see them here"
        )
    }
}
