//
//  FilmDetail.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 5/1/26.
//

import SwiftUI
import SwiftData

struct FilmDetail: View {
    let film: Film
    @State private var image: UIImage?
    @Environment(\.modelContext) private var modelContext

    @Query private var allPeople: [Person]
    @Query private var allSpecies: [Species]
    @Query private var allLocations: [Location]
    @Query private var allVehicles: [Vehicle]

    var filmPeople: [Person] {
        allPeople.filter { person in
            guard let url = person.url else { return false }
            return film.people.contains(url)
        }
    }

    var filmSpecies: [Species] {
        allSpecies.filter { species in
            guard let url = species.url else { return false }
            return film.species.contains(url)
        }
    }

    var filmLocations: [Location] {
        allLocations.filter { location in
            guard let url = location.url else { return false }
            return film.locations.contains(url)
        }
    }

    var filmVehicles: [Vehicle] {
        allVehicles.filter { vehicle in
            guard let url = vehicle.url else { return false }
            return film.vehicles.contains(url)
        }
    }

    var body: some View {
        ScrollView {
            BannerView(image: image)
            DetailInfo(film: film)
                .safeAreaPadding()

            RelatedContentSection(
                people: filmPeople,
                species: filmSpecies,
                locations: filmLocations,
                vehicles: filmVehicles
            )
            .safeAreaPadding()

            Spacer()
        }
        .ignoresSafeArea()
        .toolbar {
            ToolbarItemGroup() {
                Button {
                    let container = DataContainer(modelContainer: modelContext.container)
                    Task {
                        try? await container.toggleWatched(filmID: film.id)
                    }
                } label: {
                    Label("Watched", systemImage: film.isWatched ? "eye.fill" : "eye")
                }

                Button {
                    let container = DataContainer(modelContainer: modelContext.container)
                    Task {
                        try? await container.toggleFavorite(filmID: film.id)
                    }
                } label: {
                    Label("Favorite", systemImage: film.isFavorite ? "heart.fill" : "heart")
                }
            }
        }
        .onAppear {
            guard let banner = film.movieBanner else { return }
            do {
                let file = ImageDownloader.shared.getFileURL(url: banner)
                if FileManager.default.fileExists(atPath: file.path()) {
                    let data = try Data(contentsOf: file)
                    image = UIImage(data: data)
                } else {
                    Task {
                        do {
                            image = try await ImageDownloader.shared.image(for: banner)
                        } catch {
                            print(error)
                        }
                    }
                }
            } catch {
                print(error)
            }
        }
    }
}


#Preview {
    FilmDetail(film: .mock)
        .modelContainer(for: Film.self)
}
