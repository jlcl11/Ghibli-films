//
//  Film.swift
//  EstudioGhibli
//
//  Created by José Luis Corral López on 24/11/25.
//

import Foundation

struct Film: Identifiable, Hashable {
    let id: String
    let title: String
    let originalTitle: String
    let image: URL?
    let movieBanner: URL?
    let description: String
    let director: String
    let producer: String
    let releaseDate: String
    let runningTime: Int
    let rtScore: Int
    let people: [URL]
    let species: [URL]
    let locations: [URL]
    let vehicles: [URL]
    let url: URL
}

// MARK: - Mock Data Extension
extension Film {
    static var mock: Film {
        Film(
            id: "2baf70d1-42bb-4437-b551-e5fed5a87abe",
            title: "Castle in the Sky",
            originalTitle: "天空の城ラピュタ",
            image: URL(string: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/npOnzAbLh6VOIu3naU5QaEcTepo.jpg"),
            movieBanner: URL(string: "https://image.tmdb.org/t/p/w533_and_h300_bestv2/3cyjYtLWCBE1uvWINHFsFnE8LUK.jpg"),
            description: "The orphan Sheeta inherited a mysterious crystal that links her to the mythical sky-kingdom of Laputa. With the help of resourceful Pazu and a rollicking band of sky pirates, she makes her way to the ruins of the once-great civilization.",
            director: "Hayao Miyazaki",
            producer: "Isao Takahata",
            releaseDate: "1986",
            runningTime: 124,
            rtScore: 95,
            people: [
                URL(string: "https://ghibliapi.vercel.app/people/598f7048-74ff-41e0-92ef-87dc1ad980a9")!,
                URL(string: "https://ghibliapi.vercel.app/people/fe93adf2-2f3a-4ec4-9f68-5422f1b87c01")!,
                URL(string: "https://ghibliapi.vercel.app/people/3bc0b41e-3569-4d20-ae73-2da329bf0786")!
            ],
            species: [
                URL(string: "https://ghibliapi.vercel.app/species/af3910a6-429f-4c74-9ad5-dfe1c4aa04f2")!
            ],
            locations: [],
            vehicles: [
                URL(string: "https://ghibliapi.vercel.app/vehicles/4e09b023-f650-4747-9ab9-eacf14540cfb")!
            ],
            url: URL(string: "https://ghibliapi.vercel.app/films/2baf70d1-42bb-4437-b551-e5fed5a87abe")!
        )
    }
    
}
