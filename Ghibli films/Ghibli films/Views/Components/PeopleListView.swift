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
        WikiCategoryListView(category: .characters, isEmpty: people.isEmpty) {
            ForEach(people) { person in
                PersonRow(person: person, allFilms: allFilms)
            }
        }
    }
}


#Preview {
    NavigationStack {
        PeopleListView()
    }
    .modelContainer(for: [Person.self, Film.self])
}
