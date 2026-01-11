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
                        InfoRow(label: "Eye Color", value: person.eyeColor)
                        InfoRow(label: "Hair Color", value: person.hairColor)
                    }

                    if !personFilms.isEmpty {
                        Text("Appears in")
                            .secondaryTextStyle()

                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 8) {
                                ForEach(personFilms) { film in
                                    NavigationLink(value: film) {
                                        CachedFilmCard(film: film)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                    }
                }
             //   .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    PersonRow(person: .mock, allFilms: [.mock])
}
