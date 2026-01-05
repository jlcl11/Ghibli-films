//
//  SearchView.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 5/1/26.
//

import SwiftUI
import SwiftData

struct SearchView: View {
    @Environment(FilmsViewModel.self) private var vm
    @State private var searchVM = SearchVM()
    @Query private var films: [Film]

    var body: some View {

        NavigationStack {
            Group {
                if searchVM.filterFilms(films).isEmpty && !searchVM.searchText.isEmpty {
                    ContentUnavailableView(
                        "No Results",
                        systemImage: "magnifyingglass",
                        description: Text("No films match '\(searchVM.searchText)'")
                    )
                } else {
                    List(searchVM.filterFilms(films)) { film in
                        FilmRow(film: film)
                    }
                    .listStyle(.plain)
                    .navigationDestination(for: Film.self) { film in
                        FilmDetail(film: film)
                    }
                }
            }
            .searchable(text: $searchVM.searchText, prompt: "Search films...")
            .navigationTitle("Search")

        }
    }
}

#Preview {
    SearchView()
        .environment(FilmsViewModel())
        .modelContainer(for: Film.self)
}
