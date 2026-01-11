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


#Preview {
    NavigationStack {
        PeopleListView()
    }
    .modelContainer(for: [Person.self, Film.self])
}
