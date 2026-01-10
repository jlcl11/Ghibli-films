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
                NavigationLink {
                    PersonDetailView(person: person)
                } label: {
                    PersonRow(person: person, allFilms: allFilms)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Characters")
        }
    }
}

struct PersonRow: View {
    let person: Person
    let allFilms: [Film]

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
            }

            if !personFilms.isEmpty {
                Text("Appears in")
                    .secondaryTextStyle()

                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 8) {
                        ForEach(personFilms) { film in
                            CachedFilmCard(film: film)
                        }
                    }
                }
                .allowsHitTesting(false)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    NavigationStack {
        PeopleListView()
    }
    .modelContainer(for: [Person.self, Film.self])
}
