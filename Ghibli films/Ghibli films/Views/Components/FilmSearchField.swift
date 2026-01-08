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
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(film.title)
                            .font(.body)
                            .fontWeight(.medium)

                        Text(film.originalTitle)
                            .secondaryTextStyle()
                    }

                    Spacer()

                    Button {
                        let container = ProfileDataContainer(modelContainer: modelContext.container)
                        Task {
                            try? await container.removeFavFilm()
                            selectedFilm = nil
                        }
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.gray)
                            .font(.title3)
                    }
                    .buttonStyle(.plain)
                }
                .cardBackground()
            } else {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.gray)

                    TextField("Add your favorite film", text: $searchText)
                        .textFieldStyle(.plain)
                }
                .cardBackground()

                if !filteredFilms.isEmpty {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(Array(filteredFilms.prefix(5))) { film in
                            Button {
                                let container = ProfileDataContainer(modelContainer: modelContext.container)
                                Task {
                                    try? await container.setFavFilm(film.id)
                                    selectedFilm = film
                                    searchText = ""
                                }
                            } label: {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(film.title)
                                        .font(.body)
                                        .foregroundStyle(.primary)

                                    Text(film.originalTitle)
                                        .secondaryTextStyle()
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, 12)
                                .padding(.horizontal, 16)
                            }
                            .buttonStyle(.plain)

                            if film.id != filteredFilms.prefix(5).last?.id {
                                Divider()
                            }
                        }
                    }
                    .dropdownCardStyle()
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
