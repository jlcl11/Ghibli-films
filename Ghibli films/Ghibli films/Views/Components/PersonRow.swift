//
//  PersonRow.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 10/1/26.
//

import SwiftUI

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
                ZStack {
                    Circle()
                        .fill(.blue.opacity(0.15))
                        .frame(width: 50, height: 50)

                    Image(systemName: "person.fill")
                        .font(.title2)
                        .foregroundStyle(.blue)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(person.name)
                        .font(.headline)

                    HStack(spacing: 8) {
                        if !person.gender.isEmpty && person.gender != "NA" {
                            Label(person.gender, systemImage: "figure.stand")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }

                        if !person.age.isEmpty && person.age != "NA" {
                            Label(person.age, systemImage: "calendar")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }

                Spacer()
            }

            if !personFilms.isEmpty {
                Text("Appears in")
                    .font(.caption)
                    .foregroundStyle(.secondary)

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
    PersonRow(person: .mock, allFilms: [.mock])
}
