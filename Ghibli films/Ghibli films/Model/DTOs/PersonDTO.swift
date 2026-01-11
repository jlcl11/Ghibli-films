//
//  PersonDTO.swift
//  EstudioGhibli
//
//  Created by José Luis Corral López on 10/01/26.
//

import Foundation

struct PersonDTO: Codable {
    let id: String
    let name: String
    let gender: String
    let age: String
    let eyeColor: String
    let hairColor: String
    let films: [String]
    let species: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case gender
        case age
        case eyeColor = "eye_color"
        case hairColor = "hair_color"
        case films
        case species
        case url
    }
}

extension PersonDTO {
    nonisolated var toPerson: Person {
        Person(
            id: id,
            name: name,
            gender: gender,
            age: age,
            eyeColor: eyeColor,
            hairColor: hairColor,
            films: films.compactMap { URL(string: $0) },
            species: URL(string: species),
            url: URL(string: url)
        )
    }
}
