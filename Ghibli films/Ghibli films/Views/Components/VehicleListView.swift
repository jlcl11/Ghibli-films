//
//  VehicleListView.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 11/1/26.
//

import SwiftUI
import SwiftData

struct VehicleListView: View {
    @Query private var vehicles: [Vehicle]
    @Query private var allFilms: [Film]

    var body: some View {
        WikiCategoryListView(category: .vehicles, isEmpty: vehicles.isEmpty) {
            ForEach(vehicles) { vehicle in
                VehicleRow(vehicle: vehicle, allFilms: allFilms)
            }
        }
    }
}


#Preview {
    NavigationStack {
        VehicleListView()
    }
    .modelContainer(for: [Vehicle.self, Film.self])
}
