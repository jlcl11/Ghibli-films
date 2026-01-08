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
    
    @State private var showProfileImageSheet = false
    
    @State private var selectedEmoji: String = "😀"
    
    @State private var username: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Personal Info") {
                    VStack(alignment: .center) {
                        Button {
                            showProfileImageSheet = true
                        } label: {
                            ZStack {
                                Circle()
                                    .fill(selectedGradient.gradient)
                                    .frame(width: 100, height: 100)
                                
                                Text(selectedEmoji)
                                    .font(.system(size: 50))
                            }
                            .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
                        }
                        Divider()
                        
                        TextField(
                            "Username",
                            text: $username
                        )
                        .textInputAutocapitalization(.words)
                        
                        TextField(
                            "Username",
                            text: $username
                        )
                        .textInputAutocapitalization(.words)
                        
                    }
                }
                Section("Saved") {
                    FilmCategoryRow(
                        films: favoriteFilms,
                        title: "Favorite Films",
                        icon: "heart.fill",
                        iconColor: .red,
                        emptyStateIcon: "heart.slash",
                        emptyStateMessage: "Add films to favorites to see them here"
                    )
                    
                    FilmCategoryRow(
                        films: watchedFilms,
                        title: "Watched Films",
                        icon: "eye.fill",
                        iconColor: .blue,
                        emptyStateIcon: "eye.slash",
                        emptyStateMessage: "Mark films as watched to see them here"
                    )
                }
                
            }
        }
    }
}

#Preview {
    ProfileView()
}


