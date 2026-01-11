//
//  Location.swift
//  EstudioGhibli
//
//  Created by José Luis Corral López on 19/12/25.
//

import Foundation
import SwiftData

@Model
final class Location {
    #Index<Location>([\.name], [\.id])
    
    @Attribute(.unique) var id: String
    var name: String
    var climate: String
    var terrain: String
    var surfaceWater: String
    var residents: [URL]
    @Relationship var films: [URL]
    var url: URL?
    
    init(id: String, name: String, climate: String, terrain: String, surfaceWater: String, residents: [URL], films: [URL], url: URL? = nil) {
        self.id = id
        self.name = name
        self.climate = climate
        self.terrain = terrain
        self.surfaceWater = surfaceWater
        self.residents = residents
        self.films = films
        self.url = url
    }
}

// MARK: - Mock Data Extension
extension Location {
    static var mock: Location {
        Location(
            id: "11014596-71b0-4b3e-b8c0-1c4b15f28b9a",
            name: "Irontown",
            climate: "Continental",
            terrain: "Mountain",
            surfaceWater: "40",
            residents: [
                URL(string: "https://ghibliapi.vercel.app/people/ba924631-068e-4436-b6de-f3283fa848f0")!,
                URL(string: "https://ghibliapi.vercel.app/people/030555b3-4c92-4fce-93fb-e70c3ae3df8b")!
            ],
            films: [
                URL(string: "https://ghibliapi.vercel.app/films/0440483e-ca0e-4120-8c50-4c8cd9b965d6")!
            ],
            url: URL(string: "https://ghibliapi.vercel.app/locations/11014596-71b0-4b3e-b8c0-1c4b15f28b9a")
        )
    }
}
