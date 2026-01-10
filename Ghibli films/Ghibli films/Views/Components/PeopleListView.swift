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

    var body: some View {
        if people.isEmpty {
            ContentUnavailableView(
                "No Characters Available",
                systemImage: "person.2",
                description: Text("Characters will appear here once loaded.")
            )
        } else {
            List(people) { person in
                PersonRow(person: person)
            }
            .listStyle(.plain)
            .navigationTitle("Characters")
        }
    }
}

struct PersonRow: View {
    let person: Person

    var body: some View {
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
        .padding(.vertical, 4)
    }
}

#Preview {
    NavigationStack {
        PeopleListView()
    }
    .modelContainer(for: Person.self)
}
