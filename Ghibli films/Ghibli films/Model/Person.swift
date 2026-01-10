//
//  Person.swift
//  EstudioGhibli
//
//  Created by José Luis Corral López on 18/12/25.
//

import Foundation
import SwiftData

@Model
final class Person {
    #Index<Person>([\.name], [\.id])
    
    @Attribute(.unique) var id: String
    var name: String
    var gender: String
    var age: String
    var eyeColor: String
    var hairColor: String
    @Relationship var films: [URL]
    var species: URL?
    var url: URL?
    
    init(id: String, name: String, gender: String, age: String, eyeColor: String, hairColor: String, films: [URL], species: URL?, url: URL?) {
        self.id = id
        self.name = name
        self.gender = gender
        self.age = age
        self.eyeColor = eyeColor
        self.hairColor = hairColor
        self.films = films
        self.species = species
        self.url = url
    }
}

// MARK: - Mock Data Extension
extension Person {
    static var mock: Person {
        Person(
            id: "ba924631-068e-4436-b6de-f3283fa848f0",
            name: "Ashitaka",
            gender: "Male",
            age: "Late teens",
            eyeColor: "Brown",
            hairColor: "Brown",
            films: [
                URL(string: "https://ghibliapi.vercel.app/films/0440483e-ca0e-4120-8c50-4c8cd9b965d6")!
            ],
            species: URL(string: "https://ghibliapi.vercel.app/species/af3910a6-429f-4c74-9ad5-dfe1c4aa04f2"),
            url: URL(string: "https://ghibliapi.vercel.app/people/ba924631-068e-4436-b6de-f3283fa848f0")
        )
    }
}
