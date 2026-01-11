//
//  SpeciesListView.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 11/1/26.
//

import SwiftUI
import SwiftData

struct SpeciesListView: View {
    @Query private var species: [Species]
    @Query private var allFilms: [Film]

    var body: some View {
        WikiCategoryListView(category: .species, isEmpty: species.isEmpty) {
            ForEach(species) { speciesItem in
                SpeciesRow(species: speciesItem, allFilms: allFilms)
            }
        }
    }
}

#Preview {
    NavigationStack {
        SpeciesListView()
    }
    .modelContainer(for: [Species.self, Film.self])
}
