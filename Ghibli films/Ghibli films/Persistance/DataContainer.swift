//
//  DataContainer.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 5/1/26.
//

import Foundation
import SwiftData

@ModelActor
actor DataContainer {
    private let network = Network()

    /// Load initial data from API and sync with local storage
    func loadInitialData() async throws {
        do {
            let films = try await network.getFilms()
            try loadFilms(films: films)
        } catch {
            // If network fails, continue with cached data
            print("Network error loading films: \(error). Using cached data.")
        }

        do {
            let peopleDTO = try await network.getPeople()
            try loadPeople(people: peopleDTO.map { $0.toPerson })
        } catch {
            print("Network error loading people: \(error). Using cached data.")
        }
    }

    /// Toggle watched status for a film by ID
    func toggleWatched(filmID: String) async throws {
        let fetchDescriptor = FetchDescriptor<Film>(predicate: #Predicate { $0.id == filmID })
        guard let film = try modelContext.fetch(fetchDescriptor).first else { return }

        film.isWatched.toggle()

        if modelContext.hasChanges {
            try modelContext.save()
        }
    }

    /// Toggle favorite status for a film by ID
    func toggleFavorite(filmID: String) async throws {
        let fetchDescriptor = FetchDescriptor<Film>(predicate: #Predicate { $0.id == filmID })
        guard let film = try modelContext.fetch(fetchDescriptor).first else { return }

        film.isFavorite.toggle()

        if modelContext.hasChanges {
            try modelContext.save()
        }
    }

    /// Upsert films into SwiftData (insert or update)
    private func loadFilms(films: [FilmDTO]) throws {
        for filmDTO in films {
            let filmID = filmDTO.id

            // Check if film already exists
            var fetchFilms = FetchDescriptor<Film>(predicate: #Predicate { $0.id == filmID })
            fetchFilms.fetchLimit = 1
            let queryFilms = try modelContext.fetch(fetchFilms)

            if let existingFilm = queryFilms.first {
                // UPDATE existing film
                existingFilm.title = filmDTO.title
                existingFilm.originalTitle = filmDTO.originalTitle
                existingFilm.image = URL(string: filmDTO.image)
                existingFilm.movieBanner = URL(string: filmDTO.movieBanner)
                existingFilm.filmDescription = filmDTO.description
                existingFilm.director = filmDTO.director
                existingFilm.producer = filmDTO.producer
                existingFilm.releaseDate = filmDTO.releaseDate
                existingFilm.runningTime = Int(filmDTO.runningTime) ?? 0
                existingFilm.rtScore = Int(filmDTO.rtScore) ?? 0
                existingFilm.people = filmDTO.people.compactMap { URL(string: $0) }
                existingFilm.species = filmDTO.species.compactMap { URL(string: $0) }
                existingFilm.locations = filmDTO.locations.compactMap { URL(string: $0) }
                existingFilm.vehicles = filmDTO.vehicles.compactMap { URL(string: $0) }
                existingFilm.url = URL(string: filmDTO.url) ?? existingFilm.url
            } else {
                // INSERT new film - manually construct to avoid actor isolation issues
                let newFilm = Film(
                    id: filmDTO.id,
                    title: filmDTO.title,
                    originalTitle: filmDTO.originalTitle,
                    image: URL(string: filmDTO.image),
                    movieBanner: URL(string: filmDTO.movieBanner),
                    filmDescription: filmDTO.description,
                    director: filmDTO.director,
                    producer: filmDTO.producer,
                    releaseDate: filmDTO.releaseDate,
                    runningTime: Int(filmDTO.runningTime) ?? 0,
                    rtScore: Int(filmDTO.rtScore) ?? 0,
                    people: filmDTO.people.compactMap { URL(string: $0) },
                    species: filmDTO.species.compactMap { URL(string: $0) },
                    locations: filmDTO.locations.compactMap { URL(string: $0) },
                    vehicles: filmDTO.vehicles.compactMap { URL(string: $0) },
                    url: URL(string: filmDTO.url) ?? URL(string: "https://ghibliapi.vercel.app/films")!
                )
                modelContext.insert(newFilm)
            }
        }

        // Batch save all changes
        if modelContext.hasChanges {
            try modelContext.save()
        }
    }

    /// Upsert people into SwiftData (insert or update)
    private func loadPeople(people: [Person]) throws {
        for person in people {
            let personID = person.id

            // Check if person already exists
            var fetchPeople = FetchDescriptor<Person>(predicate: #Predicate { $0.id == personID })
            fetchPeople.fetchLimit = 1
            let queryPeople = try modelContext.fetch(fetchPeople)

            if let existingPerson = queryPeople.first {
                // UPDATE existing person
                existingPerson.name = person.name
                existingPerson.gender = person.gender
                existingPerson.age = person.age
                existingPerson.eyeColor = person.eyeColor
                existingPerson.hairColor = person.hairColor
                existingPerson.films = person.films
                existingPerson.species = person.species
                existingPerson.url = person.url
            } else {
                // INSERT new person
                modelContext.insert(person)
            }
        }

        // Batch save all changes
        if modelContext.hasChanges {
            try modelContext.save()
        }
    }
}
