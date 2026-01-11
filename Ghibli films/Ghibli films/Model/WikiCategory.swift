//
//  WikiCategory.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 11/1/26.
//

import SwiftUI

enum WikiCategory {
    case characters
    case vehicles
    case locations
    case species

    var title: String {
        switch self {
        case .characters: "Characters"
        case .vehicles: "Vehicles"
        case .locations: "Locations"
        case .species: "Species"
        }
    }

    var icon: String {
        switch self {
        case .characters: "person.2.fill"
        case .vehicles: "airplane"
        case .locations: "map.fill"
        case .species: "pawprint.fill"
        }
    }

    var color: Color {
        switch self {
        case .characters: .blue
        case .vehicles: .orange
        case .locations: .green
        case .species: .purple
        }
    }

    var emptyTitle: String {
        switch self {
        case .characters: "No Characters Available"
        case .vehicles: "No Vehicles Available"
        case .locations: "No Locations Available"
        case .species: "No Species Available"
        }
    }

    var emptyIcon: String {
        switch self {
        case .characters: "person.2"
        case .vehicles: "car.2"
        case .locations: "map"
        case .species: "pawprint"
        }
    }

    var emptyDescription: String {
        switch self {
        case .characters: "Characters will appear here once loaded."
        case .vehicles: "Vehicles will appear here once loaded."
        case .locations: "Locations will appear here once loaded."
        case .species: "Species will appear here once loaded."
        }
    }
}
