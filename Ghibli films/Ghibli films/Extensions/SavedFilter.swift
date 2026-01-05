//
//  SavedFilter.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 5/1/26.
//


enum SavedFilter: String, CaseIterable {
    case favorites = "Favorites"
    case watched = "Watched"

    var icon: String {
        switch self {
        case .favorites: return "heart.fill"
        case .watched: return "eye.fill"
        }
    }

    var emptyTitle: String {
        switch self {
        case .favorites: return "No Favorite Films"
        case .watched: return "No Watched Films"
        }
    }

    var emptyIcon: String {
        switch self {
        case .favorites: return "heart.slash"
        case .watched: return "eye.slash"
        }
    }

    var emptyDescription: String {
        switch self {
        case .favorites: return "Swipe right on films to add them to your favorites."
        case .watched: return "Swipe left on films to mark them as watched."
        }
    }
}
