//
//  NetworkRepository.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 5/1/26.
//

import Foundation
//TODO: Seguir con el resto de modelos
protocol NetworkRepository: Sendable, NetworkInteractor {
    func getFilms() async throws(NetworkError) -> [Film]
    func getFilm(id: Int) async throws(NetworkError) -> Film
    /*func getPeople() async throws(NetworkError) -> [Person]
    func getPerson(id: Int) async throws(NetworkError) -> Person
    func getSpecies() async throws(NetworkError) -> [Species]
    func getSpeciesItem(id: Int) async throws(NetworkError) -> Species
    func getVehicles() async throws(NetworkError) -> [Vehicle]
    func getVehicle(id: Int) async throws(NetworkError) -> Vehicle
    func getLocations() async throws(NetworkError) -> [Location]
    func getLocation(id: Int) async throws(NetworkError) -> Location*/
}

struct Network: NetworkRepository {

    func getFilms() async throws(NetworkError) -> [Film] {
        try await getJSON(.get(url: .getFilms), type: [FilmDTO].self).map(\.toFilm)
    }

    func getFilm(id: Int) async throws(NetworkError) -> Film {
        try await getJSON(.get(url: .getById(.films, id: id)), type: FilmDTO.self).toFilm
    }
/*
    func getPeople() async throws(NetworkError) -> [Person] {
        try await getJSON(.get(url: .getPeople), type: [PersonDTO].self).map(\.toPerson)
    }

    func getPerson(id: Int) async throws(NetworkError) -> Person {
        try await getJSON(.get(url: .getById(.people, id: id)), type: PersonDTO.self).toPerson
    }

    func getSpecies() async throws(NetworkError) -> [Species] {
        try await getJSON(.get(url: .getSpecies), type: [SpeciesDTO].self).map(\.toSpecies)
    }

    func getSpeciesItem(id: Int) async throws(NetworkError) -> Species {
        try await getJSON(.get(url: .getById(.species, id: id)), type: SpeciesDTO.self).toSpecies
    }

    func getVehicles() async throws(NetworkError) -> [Vehicle] {
        try await getJSON(.get(url: .getVehicles), type: [VehicleDTO].self).map(\.toVehicle)
    }

    func getVehicle(id: Int) async throws(NetworkError) -> Vehicle {
        try await getJSON(.get(url: .getById(.vehicles, id: id)), type: VehicleDTO.self).toVehicle
    }

    func getLocations() async throws(NetworkError) -> [Location] {
        try await getJSON(.get(url: .getLocations), type: [LocationDTO].self).map(\.toLocation)
    }

    func getLocation(id: Int) async throws(NetworkError) -> Location {
        try await getJSON(.get(url: .getById(.locations, id: id)), type: LocationDTO.self).toLocation
    }*/
}
