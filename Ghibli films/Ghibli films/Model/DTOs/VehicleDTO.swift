//
//  VehicleDTO.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 11/1/26.
//

import Foundation

struct VehicleDTO: Codable {
    let id: String
    let name: String
    let description: String
    let vehicleClass: String
    let length: String
    let pilot: String
    let films: [String]
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case vehicleClass = "vehicle_class"
        case length
        case pilot
        case films
        case url
    }
}

extension VehicleDTO {
    nonisolated var toVehicle: Vehicle {
        Vehicle(
            id: id,
            name: name,
            description: description,
            vehicleClass: vehicleClass,
            length: length,
            pilot: URL(string: pilot),
            films: films.compactMap { URL(string: $0) },
            url: URL(string: url)
        )
    }
}
