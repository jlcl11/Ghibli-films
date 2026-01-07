//
//  ProfileGradient.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 7/1/26.
//

import SwiftUI

enum ProfileGradient: String, CaseIterable, Identifiable {
    case sunset = "Sunset"
    case ocean = "Ocean"
    case forest = "Forest"
    case lavender = "Lavender"
    case fire = "Fire"
    case mint = "Mint"
    case rose = "Rose"
    case galaxy = "Galaxy"

    var id: String { rawValue }

    var gradient: LinearGradient {
        switch self {
        case .sunset:
             LinearGradient(
                colors: [Color.orange, Color.pink],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .ocean:
             LinearGradient(
                colors: [Color.blue, Color.cyan],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .forest:
             LinearGradient(
                colors: [Color.green, Color.teal],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .lavender:
             LinearGradient(
                colors: [Color.purple, Color.pink],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .fire:
             LinearGradient(
                colors: [Color.red, Color.orange],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .mint:
             LinearGradient(
                colors: [Color.mint, Color.green],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .rose:
             LinearGradient(
                colors: [Color.pink, Color.red],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .galaxy:
             LinearGradient(
                colors: [Color.indigo, Color.purple],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }
}
