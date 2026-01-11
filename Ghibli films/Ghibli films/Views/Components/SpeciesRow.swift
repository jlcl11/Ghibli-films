//
//  SpeciesRow.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 11/1/26.
//

import SwiftUI

struct SpeciesRow: View {
    let species: Species
    let allFilms: [Film]
    @State private var isExpanded = false

    var speciesFilms: [Film] {
        allFilms.filter { film in
            species.films.contains(film.url)
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 12) {
                Image(systemName: "pawprint.fill")
                    .speciesAvatarStyle()

                VStack(alignment: .leading, spacing: 4) {
                    Text(species.name)
                        .font(.headline)

                    HStack(spacing: 8) {
                        if !species.classification.isEmpty && species.classification != "NA" {
                            Label(species.classification, systemImage: "leaf")
                                .secondaryTextStyle()
                        }
                    }
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .rotationEffect(.degrees(isExpanded ? 90 : 0))
            }
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isExpanded.toggle()
                }
            }

            if isExpanded {
                VStack(alignment: .leading, spacing: 12) {
                    Divider()

                    VStack(spacing: 8) {
                        if !species.eyeColor.isEmpty && species.eyeColor != "NA" {
                            SpeciesInfoRow(label: "Eye Colors", value: species.eyeColor)
                        }
                        if !species.hairColor.isEmpty && species.hairColor != "NA" {
                            SpeciesInfoRow(label: "Hair Colors", value: species.hairColor)
                        }
                    }

                    if !speciesFilms.isEmpty {
                        Text("Appears in")
                            .secondaryTextStyle()

                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 8) {
                                ForEach(speciesFilms) { film in
                                    NavigationLink(destination: FilmDetail(film: film)) {
                                        CachedFilmCard(film: film)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                    }
                }
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .padding(.vertical, 4)
    }
}

struct SpeciesInfoRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .metadataLabelStyle()
            Spacer()
            Text(value)
                .metadataValueStyle()
        }
    }
}

#Preview {
    SpeciesRow(species: .mock, allFilms: [.mock])
}
