//
//  Film.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 5/1/26.
//

import Foundation
import SwiftData

@Model
final class FavoriteFilm {
    #Index<FavoriteFilm>([\.title])
    
    var id: String
    var title: String
    var originalTitle: String
    var image: URL?
    var movieBanner: URL?
    var filmDescription: String
    var director: String
    var producer: String
    var releaseDate: String
    var runningTime: Int
    var rtScore: Int
    var people: [URL]
    var species: [URL]
    var locations: [URL]
    var vehicles: [URL]
    var url: URL
    var scorePercentage: String {
        "\(rtScore)%"
    }
    
    init(id: String, title: String, originalTitle: String, image: URL? = nil, movieBanner: URL? = nil, filmDescription: String, director: String, producer: String, releaseDate: String, runningTime: Int, rtScore: Int, people: [URL], species: [URL], locations: [URL], vehicles: [URL], url: URL) {
        self.id = id
        self.title = title
        self.originalTitle = originalTitle
        self.image = image
        self.movieBanner = movieBanner
        self.filmDescription = filmDescription
        self.director = director
        self.producer = producer
        self.releaseDate = releaseDate
        self.runningTime = runningTime
        self.rtScore = rtScore
        self.people = people
        self.species = species
        self.locations = locations
        self.vehicles = vehicles
        self.url = url
    }
}
