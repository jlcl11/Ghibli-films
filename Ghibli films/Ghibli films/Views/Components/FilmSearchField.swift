//
//  FilmSearchField.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 8/1/26.
//

import SwiftUI
import SwiftData

struct FilmSearchField: View {
    @Environment(\.modelContext) private var modelContext

    @Binding var searchText: String
    @Binding var selectedFilm: Film?
    let films: [Film]

    private var filteredFilms: [Film] {
        guard !searchText.isEmpty else { return [] }

        return films.filter { film in
            film.title.localizedCaseInsensitiveContains(searchText) ||
            film.originalTitle.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let film = selectedFilm {
                SelectedFilmView(film: film) {
                    let container = ProfileDataContainer(modelContainer: modelContext.container)
                    Task {
                        try? await container.removeFavFilm()
                        selectedFilm = nil
                    }
                }
            } else {
                SearchInputView(searchText: $searchText)

                if !filteredFilms.isEmpty {
                    SuggestionsList(films: filteredFilms) { film in
                        let container = ProfileDataContainer(modelContainer: modelContext.container)
                        Task {
                            try? await container.setFavFilm(film.id)
                            selectedFilm = film
                            searchText = ""
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    VStack {
        FilmSearchField(
            searchText: .constant("Castle"),
            selectedFilm: .constant(nil),
            films: [.mock, .mock, .mock]
        )
        .padding()

        
    }
}
