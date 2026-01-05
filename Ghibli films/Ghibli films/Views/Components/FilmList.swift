//
//  FilmList.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 5/1/26.
//

import SwiftUI
import SwiftData

struct FilmList: View {
    var films: [Film]
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        ForEach(films) { film in
            FilmRow(film: film)
                .buttonStyle(.plain)
                .swipeActions(edge: .leading, allowsFullSwipe: true) {
                  
                        Button {
                            handleToggleWatched(for: film)
                        } label: {
                            Label(
                                film.isWatched ? "Unwatch" : "Watched",
                                systemImage: film.isWatched ? "eye.slash.fill" : "eye.fill"
                            )
                        }
                        .tint(.blue)
                    
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                  
                        Button {
                            handleToggleFavorite(for: film)
                        } label: {
                            Label(
                                film.isFavorite ? "Unfavorite" : "Favorite",
                                systemImage: film.isFavorite ? "heart.slash.fill" : "heart.fill"
                            )
                        }
                        .foregroundStyle(.red)
                    
                }
        }
    }

    // MARK: - Methods
    private func handleToggleWatched(for film: Film) {
        let container = DataContainer(modelContainer: modelContext.container)
        Task {
            try? await container.toggleWatched(filmID: film.id)
        }
    }

    private func handleToggleFavorite(for film: Film) {
        let container = DataContainer(modelContainer: modelContext.container)
        Task {
            try? await container.toggleFavorite(filmID: film.id)
        }
    }
}

#Preview {
    FilmList(films: [.mock, .mock])
        .modelContainer(for: Film.self)
}
