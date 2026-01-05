//
//  ContentView.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 5/1/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(FilmsViewModel.self) private var filmVM
    
    var body: some View {
        TabView {
            
            Tab("Films", systemImage: "film.stack") {
                FilmsListView()
            }
            
            Tab("Search", systemImage: "magnifyingglass", role: .search) {
                SearchView()
            }
            
            Tab("Wiki", systemImage: "books.vertical.fill") {
                WikiView()
            }
            
            Tab("Saved", systemImage: "bookmark.fill") {
                FavoritesFilm()
            }
            
            
            /*
             Tab("Profile", systemImage: "person.fill") {
             ProfileView()
             }*/
        }
        .tabBarMinimizeBehavior(.onScrollDown)
    }
}

#Preview {
    ContentView()
        .environment(FilmsViewModel())
        .modelContainer(for: Film.self)
}
