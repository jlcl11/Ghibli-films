//
//  FilmDTO.swift
//  EstudioGhibli
//
//  Created by José Luis Corral López on 24/11/25.
//

import Foundation

struct FilmDTO: Codable {
    let id: String
    let title: String
    let originalTitle: String
    let image: String
    let movieBanner: String
    let description: String
    let director: String
    let producer: String
    let releaseDate: String
    let runningTime: String
    let rtScore: String
    let people: [String]
    let species: [String]
    let locations: [String]
    let vehicles: [String]
    let url: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case originalTitle = "original_title"
        case image
        case movieBanner = "movie_banner"
        case description
        case director
        case producer
        case releaseDate = "release_date"
        case runningTime = "running_time"
        case rtScore = "rt_score"
        case people
        case species
        case locations
        case vehicles
        case url
    }
}

extension FilmDTO {
    var toFilm: Film {
        // Helper to filter out incomplete URLs (those ending with just a slash and no ID)
        func validURLs(from strings: [String]) -> [URL] {
            strings.compactMap { urlString in
                guard let url = URL(string: urlString),
                      !urlString.hasSuffix("/species/"),
                      !urlString.hasSuffix("/vehicles/"),
                      !urlString.hasSuffix("/locations/"),
                      !urlString.hasSuffix("/people/"),
                      !urlString.hasSuffix("/films/") else {
                    return nil
                }
                return url
            }
        }

        return Film(
            id: id,
            title: title,
            originalTitle: originalTitle,
            image: URL(string: image),
            movieBanner: URL(string: movieBanner),
            description: description,
            director: director,
            producer: producer,
            releaseDate: releaseDate,
            runningTime: Int(runningTime) ?? 0,
            rtScore: Int(rtScore) ?? 0,
            people: validURLs(from: people),
            species: validURLs(from: species),
            locations: validURLs(from: locations),
            vehicles: validURLs(from: vehicles),
            url: URL(string: url)!
        )
    }
}
 
