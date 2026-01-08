//
//  Profile.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 8/1/26.
//

import Foundation
import SwiftData

@Model
final class Profile {
    var userName: String
    var selectedEmoji: String
    var selectedGradient: String
    @Relationship(inverse: \Film.id) var favFilm: String?

    init(userName: String, selectedEmoji: String, selectedGradient: String, favFilm: String? = nil) {
        self.userName = userName
        self.selectedEmoji = selectedEmoji
        self.selectedGradient = selectedGradient
        self.favFilm = favFilm
    }
}
