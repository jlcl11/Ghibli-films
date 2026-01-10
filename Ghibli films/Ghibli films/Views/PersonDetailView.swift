//
//  PersonDetailView.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 10/1/26.
//

import SwiftUI
import SwiftData

struct PersonDetailView: View {
    let person: Person
    @Query private var allFilms: [Film]

    var personFilms: [Film] {
        allFilms.filter { film in
            person.films.contains(film.url)
        }
    }

    var body: some View {
        List {
            Section("Info") {
                InfoRow(label: "Gender", value: person.gender)
                InfoRow(label: "Age", value: person.age)
                InfoRow(label: "Eye Color", value: person.eyeColor)
                InfoRow(label: "Hair Color", value: person.hairColor)
            }

            Section("Films") {
                if personFilms.isEmpty {
                    ContentUnavailableView(
                        "No Films",
                        systemImage: "film",
                        description: Text("No films found for this character.")
                    )
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 12) {
                            ForEach(personFilms) { film in
                                NavigationLink(value: film) {
                                    CachedFilmCard(film: film)
                                }
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
        }
        .navigationTitle(person.name)
        .navigationDestination(for: Film.self) { film in
            FilmDetail(film: film)
        }
    }
}

struct InfoRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .metadataLabelStyle()
            Spacer()
            Text(value.isEmpty || value == "NA" ? "Unknown" : value)
                .metadataValueStyle()
        }
    }
}

#Preview {
    NavigationStack {
        PersonDetailView(person: .mock)
    }
    .modelContainer(for: [Person.self, Film.self])
}
