//
//  SpeciesDTO.swift
//  EstudioGhibli
//
//  Created by José Luis Corral López on 10/01/26.
//

import Foundation

struct SpeciesDTO: Codable {
    let id: String
    let name: String
    let classification: String
    let eyeColor: String
    let hairColor: String
    let people: [String]
    let films: [String]
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case classification
        case eyeColor = "eye_colors"
        case hairColor = "hair_colors"
        case people
        case films
        case url
    }
}

extension SpeciesDTO {
    nonisolated var toSpecies: Species {
        Species(
            id: id,
            name: name,
            classification: classification,
            eyeColor: eyeColor,
            hairColor: hairColor,
            people: people.compactMap { URL(string: $0) },
            films: films.compactMap { URL(string: $0) },
            url: URL(string: url)
        )
    }
}
