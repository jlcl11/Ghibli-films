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

    var title: String {
        switch self {
        case .characters: "Characters"
        case .vehicles: "Vehicles"
        case .locations: "Locations"
        }
    }

    var icon: String {
        switch self {
        case .characters: "person.2.fill"
        case .vehicles: "airplane"
        case .locations: "map.fill"
        }
    }

    var color: Color {
        switch self {
        case .characters: .blue
        case .vehicles: .orange
        case .locations: .green
        }
    }

    var emptyTitle: String {
        switch self {
        case .characters: "No Characters Available"
        case .vehicles: "No Vehicles Available"
        case .locations: "No Locations Available"
        }
    }

    var emptyIcon: String {
        switch self {
        case .characters: "person.2"
        case .vehicles: "car.2"
        case .locations: "map"
        }
    }

    var emptyDescription: String {
        switch self {
        case .characters: "Characters will appear here once loaded."
        case .vehicles: "Vehicles will appear here once loaded."
        case .locations: "Locations will appear here once loaded."
        }
    }
}
