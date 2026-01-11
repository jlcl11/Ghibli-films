//
//  Vehicle.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 11/1/26.
//

import Foundation
import SwiftData

@Model
final class Vehicle {
    #Index<Vehicle>([\.name], [\.id])
    
    @Attribute(.unique) var id: String
    var name: String
    var vehicleDescription: String
    var vehicleClass: String
    var length: String
    var pilot: URL?
    @Relationship var films: [URL]
    var url: URL?
    
    init(id: String, name: String, description: String, vehicleClass: String, length: String, pilot: URL? = nil, films: [URL], url: URL? = nil) {
        self.id = id
        self.name = name
        self.vehicleDescription = description
        self.vehicleClass = vehicleClass
        self.length = length
        self.pilot = pilot
        self.films = films
        self.url = url
    }
}

// MARK: - Mock Data Extension
extension Vehicle {
    static var mock: Vehicle {
        Vehicle(
            id: "4e09b023-f650-4747-9ab9-eacf14540cfb",
            name: "Air Destroyer Goliath",
            description: "A military airship utilized by the government to access Laputa",
            vehicleClass: "Airship",
            length: "1,000",
            pilot: URL(string: "https://ghibliapi.vercel.app/people/40c005ce-3725-4f15-8409-3e1b1b14b583"),
            films: [
                URL(string: "https://ghibliapi.vercel.app/films/2baf70d1-42bb-4437-b551-e5fed5a87abe")!
            ],
            url: URL(string: "https://ghibliapi.vercel.app/vehicles/4e09b023-f650-4747-9ab9-eacf14540cfb")
        )
    }
}

