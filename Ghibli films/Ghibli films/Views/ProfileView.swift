//
//  ProfileView.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 7/1/26.
//

import SwiftUI
import SwiftData

struct ProfileView: View {
    @Query(filter: #Predicate<Film> { $0.isFavorite == true }) private var favoriteFilms: [Film]
    
    @Query(filter: #Predicate<Film> { $0.isWatched == true }) private var watchedFilms: [Film]
    
    @State private var selectedGradient: ProfileGradient = .sunset
    
    @State private var selectedEmoji: String = "😀"
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Personal Info") {
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                }
                
                Section("Saved") {
                    NavigationLink {
                        FilmsGridView(
                            films: favoriteFilms,
                            title: "Favorite Films",
                            emptyStateIcon: "heart.slash",
                            emptyStateMessage: "Add films to favorites to see them here")
                        
                    } label: {
                        VStack {
                            HStack{
                                Label("Favorite Films", systemImage: "heart.fill")
                                    .foregroundStyle(.red)
                                    .fontWeight(.semibold)
                                Spacer()
                                Text("\(favoriteFilms.count)")
                            }
                            
                            ScrollView(.horizontal) {
                                LazyHStack {
                                    ForEach(favoriteFilms) {film in
                                        CachedFilmCard(film: film)
                                    }
                                }
                            }
                        }
                    }
                    
                    NavigationLink {
                        FilmsGridView(
                            films: watchedFilms,
                            title: "Watched Films",
                            emptyStateIcon: "eye.slash",
                            emptyStateMessage: "Add films to favorites to see them here")
                        
                    } label: {
                        VStack {
                            HStack{
                                Label("Watched Films", systemImage: "eye.fill")
                                    .foregroundStyle(.blue)
                                    .fontWeight(.semibold)
                                Spacer()
                                Text("\(watchedFilms.count)")
                            }
                            
                            ScrollView(.horizontal) {
                                LazyHStack {
                                    ForEach(watchedFilms) {film in
                                        CachedFilmCard(film: film)
                                    }
                                }
                            }
                        }
                    }
                    
                }
                
            }
        }
    }
}

#Preview {
    ProfileView()
}
