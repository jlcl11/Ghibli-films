//
//  ContentView.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 5/1/26.
//

import SwiftUI

struct ContentView: View {
    @Environment(FilmsViewModel.self) private var filmVM
    
    var body: some View {
        TabView {
            
            Tab("Films", systemImage: "film.stack") {
                FilmsListView()
            }
            
            /*  Tab("Wiki", systemImage: "books.vertical.fill") {
             WikiView()
             }
             
             Tab("Favorites", systemImage: "heart.fill") {
             FavoritesView()
             }
             
             Tab("Search", systemImage: "magnifyingglass", role: .search) {
             SearchView()
             }
             
             Tab("Profile", systemImage: "person.fill") {
             ProfileView()
             }*/
        }
        .task(priority: .high) {
            await filmVM.getFilms()
        }
    }
}

#Preview {
    ContentView().environment(FilmsViewModel())
}
