//
//  URL.swift
//  EmpleadosAPI
//
//  Created by Julio César Fernández Muñoz on 19/11/25.
//

import Foundation

let api = URL(string: "https://ghibliapi.vercel.app")!
 
extension URL {
    enum GhibliEndpoint: String {
        case films
        case locations
        case people
        case species
        case vehicles
    }
    
    static let getFilms = api.appendingPathComponent(GhibliEndpoint.films.rawValue)
    static let getLocations = api.appendingPathComponent(GhibliEndpoint.locations.rawValue)
    static let getPeople = api.appendingPathComponent(GhibliEndpoint.people.rawValue)
    static let getSpecies = api.appendingPathComponent(GhibliEndpoint.species.rawValue)
    static let getVehicles = api.appendingPathComponent(GhibliEndpoint.vehicles.rawValue)
    
    static func getById(_ endpoint: GhibliEndpoint, id: Int) -> URL {
        api.appendingPathComponent(endpoint.rawValue)
           .appendingPathComponent("\(id)")
    }
    
}
