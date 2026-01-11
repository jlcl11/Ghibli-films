//
//  LocationListView.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 11/1/26.
//

import SwiftUI
import SwiftData

struct LocationListView: View {
    @Query private var locations: [Location]
    @Query private var allFilms: [Film]

    var body: some View {
        WikiCategoryListView(category: .locations, isEmpty: locations.isEmpty) {
            ForEach(locations) { location in
                LocationRow(location: location, allFilms: allFilms)
            }
        }
    }
}

#Preview {
    NavigationStack {
        LocationListView()
    }
    .modelContainer(for: [Location.self, Film.self])
}
