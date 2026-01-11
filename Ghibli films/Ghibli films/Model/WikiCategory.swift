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

    var title: String {
        switch self {
        case .characters: "Characters"
        case .vehicles: "Vehicles"
        }
    }

    var icon: String {
        switch self {
        case .characters: "person.2.fill"
        case .vehicles: "airplane"
        }
    }

    var color: Color {
        switch self {
        case .characters: .blue
        case .vehicles: .orange
        }
    }

    var emptyTitle: String {
        switch self {
        case .characters: "No Characters Available"
        case .vehicles: "No Vehicles Available"
        }
    }

    var emptyIcon: String {
        switch self {
        case .characters: "person.2"
        case .vehicles: "car.2"
        }
    }

    var emptyDescription: String {
        switch self {
        case .characters: "Characters will appear here once loaded."
        case .vehicles: "Vehicles will appear here once loaded."
        }
    }
}
