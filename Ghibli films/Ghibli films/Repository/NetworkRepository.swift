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

