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

    var body: some View {
        NavigationStack {
            if favoriteFilms.isEmpty {
                ContentUnavailableView(
                    "No Favorite Films",
                    systemImage: "heart.slash",
                    description: Text("Swipe right on films to add them to your favorites.")
                )
            } else {
                List {
                    FilmList(films: favoriteFilms)
                }
                .listStyle(.plain)
                .navigationTitle("Favorites")
                .navigationDestination(for: Film.self) { film in
                    FilmDetail(film: film)
                }
            }
        }
    }
}

#Preview {
    FavoritesFilm()
        .modelContainer(for: Film.self)
}
