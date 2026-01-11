//
//  LocationDTO.swift
//  EstudioGhibli
//
//  Created by José Luis Corral López on 10/01/26.
//

import Foundation

struct LocationDTO: Codable {
    let id: String
    let name: String
    let climate: String
    let terrain: String
    let surfaceWater: String
    let residents: [String]
    let films: [String]
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case climate
        case terrain
        case surfaceWater = "surface_water"
        case residents
        case films
        case url
    }
}

extension LocationDTO {
    nonisolated var toLocation: Location {
        Location(
            id: id,
            name: name,
            climate: climate,
            terrain: terrain,
            surfaceWater: surfaceWater,
            residents: residents.compactMap { URL(string: $0) },
            films: films.compactMap { URL(string: $0) },
            url: URL(string: url)
        )
    }
}
