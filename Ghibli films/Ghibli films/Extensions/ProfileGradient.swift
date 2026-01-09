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

    var gradient: MeshGradient {
        switch self {
        case .sunset:
            MeshGradient(
                width: 3, height: 3,
                points: [
                    [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                    [0.0, 0.5], [0.5, 0.5], [1.0, 0.5],
                    [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
                ],
                colors: [
                    Color(red: 1.0, green: 0.8, blue: 0.2),
                    Color(red: 1.0, green: 0.5, blue: 0.3),
                    Color(red: 1.0, green: 0.3, blue: 0.4),
                    Color(red: 1.0, green: 0.4, blue: 0.2),
                    Color(red: 1.0, green: 0.2, blue: 0.5),
                    Color(red: 0.9, green: 0.1, blue: 0.6),
                    Color(red: 0.8, green: 0.2, blue: 0.5),
                    Color(red: 0.6, green: 0.1, blue: 0.7),
                    Color(red: 0.4, green: 0.0, blue: 0.6)
                ]
            )
        case .ocean:
            MeshGradient(
                width: 3, height: 3,
                points: [
                    [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                    [0.0, 0.5], [0.5, 0.5], [1.0, 0.5],
                    [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
                ],
                colors: [
                    Color(red: 0.0, green: 1.0, blue: 0.9),
                    Color(red: 0.0, green: 0.8, blue: 1.0),
                    Color(red: 0.2, green: 0.6, blue: 1.0),
                    Color(red: 0.0, green: 0.7, blue: 0.8),
                    Color(red: 0.0, green: 0.5, blue: 0.9),
                    Color(red: 0.1, green: 0.3, blue: 0.8),
                    Color(red: 0.0, green: 0.4, blue: 0.6),
                    Color(red: 0.0, green: 0.2, blue: 0.5),
                    Color(red: 0.05, green: 0.1, blue: 0.4)
                ]
            )
        case .forest:
            MeshGradient(
                width: 3, height: 3,
                points: [
                    [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                    [0.0, 0.5], [0.5, 0.5], [1.0, 0.5],
                    [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
                ],
                colors: [
                    Color(red: 0.8, green: 1.0, blue: 0.2),
                    Color(red: 0.5, green: 0.9, blue: 0.3),
                    Color(red: 0.2, green: 0.8, blue: 0.4),
                    Color(red: 0.4, green: 0.9, blue: 0.3),
                    Color(red: 0.1, green: 0.7, blue: 0.5),
                    Color(red: 0.0, green: 0.6, blue: 0.5),
                    Color(red: 0.1, green: 0.6, blue: 0.4),
                    Color(red: 0.0, green: 0.5, blue: 0.4),
                    Color(red: 0.0, green: 0.3, blue: 0.3)
                ]
            )
        case .lavender:
            MeshGradient(
                width: 3, height: 3,
                points: [
                    [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                    [0.0, 0.5], [0.5, 0.5], [1.0, 0.5],
                    [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
                ],
                colors: [
                    Color(red: 1.0, green: 0.7, blue: 0.9),
                    Color(red: 0.9, green: 0.5, blue: 1.0),
                    Color(red: 0.7, green: 0.4, blue: 1.0),
                    Color(red: 0.9, green: 0.6, blue: 0.9),
                    Color(red: 0.7, green: 0.4, blue: 0.9),
                    Color(red: 0.5, green: 0.3, blue: 0.9),
                    Color(red: 0.6, green: 0.3, blue: 0.8),
                    Color(red: 0.4, green: 0.2, blue: 0.7),
                    Color(red: 0.3, green: 0.1, blue: 0.6)
                ]
            )
        case .fire:
            MeshGradient(
                width: 3, height: 3,
                points: [
                    [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                    [0.0, 0.5], [0.5, 0.5], [1.0, 0.5],
                    [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
                ],
                colors: [
                    Color(red: 1.0, green: 1.0, blue: 0.4),
                    Color(red: 1.0, green: 0.9, blue: 0.2),
                    Color(red: 1.0, green: 0.7, blue: 0.0),
                    Color(red: 1.0, green: 0.7, blue: 0.1),
                    Color(red: 1.0, green: 0.5, blue: 0.0),
                    Color(red: 1.0, green: 0.3, blue: 0.0),
                    Color(red: 0.9, green: 0.3, blue: 0.0),
                    Color(red: 0.8, green: 0.1, blue: 0.0),
                    Color(red: 0.5, green: 0.0, blue: 0.0)
                ]
            )
        case .mint:
            MeshGradient(
                width: 3, height: 3,
                points: [
                    [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                    [0.0, 0.5], [0.5, 0.5], [1.0, 0.5],
                    [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
                ],
                colors: [
                    Color(red: 0.6, green: 1.0, blue: 0.9),
                    Color(red: 0.4, green: 1.0, blue: 0.8),
                    Color(red: 0.3, green: 0.9, blue: 1.0),
                    Color(red: 0.3, green: 0.9, blue: 0.7),
                    Color(red: 0.2, green: 0.8, blue: 0.9),
                    Color(red: 0.3, green: 0.6, blue: 1.0),
                    Color(red: 0.2, green: 0.7, blue: 0.8),
                    Color(red: 0.3, green: 0.5, blue: 0.9),
                    Color(red: 0.4, green: 0.3, blue: 0.8)
                ]
            )
        case .rose:
            MeshGradient(
                width: 3, height: 3,
                points: [
                    [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                    [0.0, 0.5], [0.5, 0.5], [1.0, 0.5],
                    [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
                ],
                colors: [
                    Color(red: 1.0, green: 0.9, blue: 0.8),
                    Color(red: 1.0, green: 0.7, blue: 0.7),
                    Color(red: 1.0, green: 0.5, blue: 0.6),
                    Color(red: 1.0, green: 0.7, blue: 0.6),
                    Color(red: 1.0, green: 0.4, blue: 0.5),
                    Color(red: 0.9, green: 0.2, blue: 0.5),
                    Color(red: 0.9, green: 0.4, blue: 0.5),
                    Color(red: 0.8, green: 0.2, blue: 0.4),
                    Color(red: 0.6, green: 0.1, blue: 0.3)
                ]
            )
        case .galaxy:
            MeshGradient(
                width: 3, height: 3,
                points: [
                    [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                    [0.0, 0.5], [0.5, 0.5], [1.0, 0.5],
                    [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
                ],
                colors: [
                    Color(red: 0.9, green: 0.3, blue: 0.8),
                    Color(red: 0.6, green: 0.2, blue: 0.9),
                    Color(red: 0.3, green: 0.1, blue: 0.7),
                    Color(red: 0.7, green: 0.1, blue: 0.6),
                    Color(red: 0.4, green: 0.1, blue: 0.8),
                    Color(red: 0.2, green: 0.1, blue: 0.5),
                    Color(red: 0.5, green: 0.0, blue: 0.5),
                    Color(red: 0.2, green: 0.0, blue: 0.4),
                    Color(red: 0.1, green: 0.0, blue: 0.2)
                ]
            )
        }
    }
}
