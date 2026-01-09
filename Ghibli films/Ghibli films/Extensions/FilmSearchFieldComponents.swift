//
//  FilmSearchFieldComponents.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 9/1/26.
//

import SwiftUI

extension FilmSearchField {
    struct SelectedFilmView: View {
        let film: Film
        let onRemove: () -> Void

        var body: some View {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(film.title)
                        .font(.body)
                        .fontWeight(.medium)

                    Text(film.originalTitle)
                        .secondaryTextStyle()
                }

                Spacer()

                Button(action: onRemove) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.gray)
                        .font(.title3)
                }
                .buttonStyle(.plain)
            }
            .cardBackground()
        }
    }

    struct SearchInputView: View {
        @Binding var searchText: String

        var body: some View {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.gray)

                TextField("Add your favorite film", text: $searchText)
                    .textFieldStyle(.plain)
            }
            .cardBackground()
        }
    }

    struct SuggestionsList: View {
        let films: [Film]
        let onSelect: (Film) -> Void

        var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(Array(films.prefix(5))) { film in
                    SuggestionRow(film: film) {
                        onSelect(film)
                    }

                    if film.id != films.prefix(5).last?.id {
                        Divider()
                    }
                }
            }
            .dropdownCardStyle()
        }
    }

    struct SuggestionRow: View {
        let film: Film
        let onTap: () -> Void

        var body: some View {
            Button(action: onTap) {
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
        }
    }
}
