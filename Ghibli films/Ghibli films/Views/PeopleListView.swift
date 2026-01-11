//
//  PeopleListView.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 10/1/26.
//

import SwiftUI
import SwiftData

struct PeopleListView: View {
    @Query private var people: [Person]
    @Query private var allFilms: [Film]

    var body: some View {
        if people.isEmpty {
            ContentUnavailableView(
                "No Characters Available",
                systemImage: "person.2",
                description: Text("Characters will appear here once loaded.")
            )
        } else {
            List(people) { person in
                PersonRow(person: person, allFilms: allFilms)
            }
            .listStyle(.plain)
            .navigationTitle("Characters")
        }
    }
}

struct PersonRow: View {
    let person: Person
    let allFilms: [Film]
    @State private var isExpanded = false

    var personFilms: [Film] {
        allFilms.filter { film in
            person.films.contains(film.url)
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 12) {
                Image(systemName: "person.fill")
                    .personAvatarStyle()

                VStack(alignment: .leading, spacing: 4) {
                    Text(person.name)
                        .font(.headline)

                    HStack(spacing: 8) {
                        if !person.gender.isEmpty && person.gender != "NA" {
                            Label(person.gender, systemImage: "figure.stand")
                                .secondaryTextStyle()
                        }

                        if !person.age.isEmpty && person.age != "NA" {
                            Label(person.age, systemImage: "calendar")
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
                        PersonInfoRow(label: "Eye Color", value: person.eyeColor)
                        PersonInfoRow(label: "Hair Color", value: person.hairColor)
                    }

                    if !personFilms.isEmpty {
                        Text("Appears in")
                            .secondaryTextStyle()

                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 8) {
                                ForEach(personFilms) { film in
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

struct PersonInfoRow: View {
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
        PeopleListView()
    }
    .modelContainer(for: [Person.self, Film.self])
}
