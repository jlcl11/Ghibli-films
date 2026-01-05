//
//  FavoritesFilm.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 5/1/26.
//

import SwiftUI
import SwiftData

struct FavoritesFilm: View {
    @Query(filter: #Predicate<Film> { $0.isFavorite == true })
    private var favoriteFilms: [Film]

    @Query(filter: #Predicate<Film> { $0.isWatched == true })
    private var watchedFilms: [Film]

    @State private var selectedFilter: SavedFilter = .favorites

    private var displayedFilms: [Film] {
        switch selectedFilter {
        case .favorites: return favoriteFilms
        case .watched: return watchedFilms
        }
    }

    var body: some View {
        NavigationStack {
            Group {
                if displayedFilms.isEmpty {
                    ContentUnavailableView(
                        selectedFilter.emptyTitle,
                        systemImage: selectedFilter.emptyIcon,
                        description: Text(selectedFilter.emptyDescription)
                    )
                } else {
                    List {
                        FilmList(films: displayedFilms)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle(selectedFilter.rawValue)
            .navigationDestination(for: Film.self) { film in
                FilmDetail(film: film)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Filter", selection: $selectedFilter) {
                            ForEach(SavedFilter.allCases, id: \.self) { filter in
                                Label(filter.rawValue, systemImage: filter.icon)
                                    .tag(filter)
                            }
                        }
                    } label: {
                        Label("Filter", systemImage: selectedFilter.icon)
                    }
                }
            }
        }
    }
}

#Preview {
    FavoritesFilm()
        .modelContainer(for: Film.self)
}
