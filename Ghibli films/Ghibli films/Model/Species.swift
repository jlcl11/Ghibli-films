//
//  Species.swift
//  EstudioGhibli
//
//  Created by José Luis Corral López on 10/01/26.
//

import Foundation
import SwiftData

@Model
final class Species {
    #Index<Species>([\.name], [\.id])
    
    @Attribute(.unique) var id: String
    var name: String
    var classification: String
    var eyeColor: String
    var hairColor: String
    var people: [URL]
    @Relationship var films: [URL]
    var url: URL?
    
    init(id: String, name: String, classification: String, eyeColor: String, hairColor: String, people: [URL], films: [URL], url: URL? = nil) {
        self.id = id
        self.name = name
        self.classification = classification
        self.eyeColor = eyeColor
        self.hairColor = hairColor
        self.people = people
        self.films = films
        self.url = url
    }
}

// MARK: - Mock Data Extension
extension Species {
    static var mock: Species {
        Species(
            id: "af3910a6-429f-4c74-9ad5-dfe1c4aa04f2",
            name: "Human",
            classification: "Mammal",
            eyeColor: "Black, Blue, Brown, Grey, Green, Hazel",
            hairColor: "Black, Blonde, Brown, Grey, White",
            people: [
                URL(string: "https://ghibliapi.vercel.app/people/ba924631-068e-4436-b6de-f3283fa848f0")!,
                URL(string: "https://ghibliapi.vercel.app/people/e9356bb5-4d4a-4c93-aadc-c83e514bffe3")!
            ],
            films: [
                URL(string: "https://ghibliapi.vercel.app/films/2baf70d1-42bb-4437-b551-e5fed5a87abe")!,
                URL(string: "https://ghibliapi.vercel.app/films/12cfb892-aac0-4c5b-94af-521852e46d6a")!
            ],
            url: URL(string: "https://ghibliapi.vercel.app/species/af3910a6-429f-4c74-9ad5-dfe1c4aa04f2")
        )
    }
}
