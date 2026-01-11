//
//  NetworkRepository.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 5/1/26.
//

import Foundation
//TODO: Seguir con el resto de modelos
protocol NetworkRepository: Sendable, NetworkInteractor {
    func getFilms() async throws(NetworkError) -> [FilmDTO]
    func getFilm(id: Int) async throws(NetworkError) -> FilmDTO
    func getPeople() async throws(NetworkError) -> [PersonDTO]
    func getVehicles() async throws(NetworkError) -> [VehicleDTO]
    func getLocations() async throws(NetworkError) -> [LocationDTO]
    func getSpecies() async throws(NetworkError) -> [SpeciesDTO]
}

struct Network: NetworkRepository {

    func getFilms() async throws(NetworkError) -> [FilmDTO] {
        try await getJSON(.get(url: .getFilms), type: [FilmDTO].self)
    }

    func getFilm(id: Int) async throws(NetworkError) -> FilmDTO {
        try await getJSON(.get(url: .getById(.films, id: id)), type: FilmDTO.self)
    }

    func getPeople() async throws(NetworkError) -> [PersonDTO] {
        try await getJSON(.get(url: .getPeople), type: [PersonDTO].self)
    }

    func getVehicles() async throws(NetworkError) -> [VehicleDTO] {
        try await getJSON(.get(url: .getVehicles), type: [VehicleDTO].self)
    }

    func getLocations() async throws(NetworkError) -> [LocationDTO] {
        try await getJSON(.get(url: .getLocations), type: [LocationDTO].self)
    }

    func getSpecies() async throws(NetworkError) -> [SpeciesDTO] {
        try await getJSON(.get(url: .getSpecies), type: [SpeciesDTO].self)
    }
}
