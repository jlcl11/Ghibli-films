//
//  ProfileView.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 7/1/26.
//

import SwiftUI
import SwiftData

struct ProfileView: View {
    @Environment(\.modelContext) private var modelContext

    @Query(filter: #Predicate<Film> { $0.isFavorite == true }) private var favoriteFilms: [Film]

    @Query(filter: #Predicate<Film> { $0.isWatched == true }) private var watchedFilms: [Film]

    @Query private var userProfile: [Profile]

    @State private var selectedGradient: ProfileGradient = .sunset
    @State private var searchVM = SearchVM()
    @State private var showProfileImageSheet = false
    @State private var selectedEmoji: String = "😀"
    @State private var username: String = ""
    @State private var selectedFilm: Film?

    @Query private var films: [Film]

    var body: some View {
        NavigationStack {
            Form {
                Section("Personal Info") {
                    VStack(alignment: .center) {
                        Button {
                            showProfileImageSheet.toggle()
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
                        .padding()
                        .onChange(of: username) { _, newValue in
                            Task {
                                let container = ProfileDataContainer(modelContainer: modelContext.container)
                                try? await container.updateUserName(newValue)
                            }
                        }

                        Divider()

                        FilmSearchField(
                            searchText: $searchVM.searchText,
                            selectedFilm: $selectedFilm,
                            films: films
                        )

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
            .onAppear {
                loadProfileData()
            }
            .onChange(of: userProfile) { _, _ in
                loadProfileData()
            }
            .navigationTitle("Profile")
            .sheet(isPresented: $showProfileImageSheet) {
                ProfileImagePicker(
                    selectedEmoji: $selectedEmoji,
                    selectedGradient: $selectedGradient
                )
            }
        }
    }

    private func loadProfileData() {
        guard let profile = userProfile.first else { return }
        username = profile.userName
        selectedEmoji = profile.selectedEmoji
        if let gradient = ProfileGradient(rawValue: profile.selectedGradient) {
            selectedGradient = gradient
        }
        if let favFilmID = profile.favFilm {
            selectedFilm = films.first { $0.id == favFilmID }
        } else {
            selectedFilm = nil
        }
    }
}

#Preview {
    ProfileView()
}


