//
//  FilmsListView.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 5/1/26.
//

import SwiftUI
import SwiftData

struct FilmsListView: View {
    @Environment(FilmsViewModel.self) private var filmVM
    @Environment(\.modelContext) private var modelContext
    @Query private var films: [Film]

    var featuredFilms: [Film] {
        films.sorted(by: { $0.rtScore > $1.rtScore }).prefix(5).map { $0 }
    }

    var body: some View {
        NavigationStack {
            if films.isEmpty {
                ContentUnavailableView(
                    "No Films Available",
                    systemImage: "film",
                    description: Text("Pull to refresh to load films from the server.")
                )
            } else {
                List {
                    Section {
                        FilmsCarrousel(featuredFilms: featuredFilms)
                    } header: {
                        Text("Top Rated")
                            .font(.headline)
                            .foregroundStyle(.primary)
                            .textCase(nil)
                    }

                    Section {
                        FilmList(films: films)
                    } header: {
                        Text("All Films")
                            .font(.headline)
                            .foregroundStyle(.primary)
                            .textCase(nil)
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Films")
                .navigationDestination(for: Film.self) { film in
                    FilmDetail(film: film)
                }
            }
        }
        .refreshable {
            await filmVM.refreshFilms(modelContext: modelContext)
        }
    }
}

#Preview {
    @Previewable @State var vm = FilmsViewModel()
    FilmsListView()
        .environment(vm)
        .modelContainer(for: Film.self)
}
