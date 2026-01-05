//
//  SearchView.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 5/1/26.
//

import SwiftUI

struct SearchView: View {
    @Environment(FilmsViewModel.self) private var vm
    @State private var searchVM = SearchVM()
    
    var body: some View {
        
        NavigationStack {
            Group {
                if searchVM.filterFilms(vm.films).isEmpty && !searchVM.searchText.isEmpty {
                    ContentUnavailableView(
                        "No Results",
                        systemImage: "magnifyingglass",
                        description: Text("No films match '\(searchVM.searchText)'")
                    )
                } else {
                    List(searchVM.filterFilms(vm.films)) { film in
                        FilmRow(
                            film: film, isSwipable: false
                            
                        )
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
    SearchView().environment(FilmsViewModel())
}
