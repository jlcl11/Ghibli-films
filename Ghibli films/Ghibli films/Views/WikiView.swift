//
//  WikiView.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 5/1/26.
//

import SwiftUI
import SwiftData

struct WikiView: View {
    @Query var people: [Person] = []
    @Query var vehicles: [Vehicle] = []
    @Query var locations: [Location] = []

    var body: some View {
        NavigationStack {
            List {
                Section {
                    LazyVGrid(
                        columns: [GridItem(.flexible()), GridItem(.flexible())],
                        spacing: 12
                    )  {
                        StatCard(
                            icon: "person.2.fill",
                            value:  people.count,
                            label: "Characters",
                            color: .blue
                        )
                        StatCard(
                            icon: "airplane",
                            value: vehicles.count,
                            label: "Vehicles",
                            color: .orange
                        )
                        StatCard(
                            icon: "map.fill",
                            value: locations.count,
                            label: "Locations",
                            color: .green
                        )
                    }
                }.listRowBackground(Color.clear)

                Section {
                    WikiCategoryRow(icon: "person.2.fill", title: "Characters", subtitle: "\(people.count) characters", color: .blue, destination: AnyView(PeopleListView()))
                    WikiCategoryRow(icon: "airplane", title: "Vehicles", subtitle: "\(vehicles.count) vehicles", color: .orange, destination: AnyView(VehicleListView()))
                    WikiCategoryRow(icon: "map.fill", title: "Locations", subtitle: "\(locations.count) locations", color: .green, destination: AnyView(LocationListView()))
                }
            }
            .navigationTitle("Wiki")
            .navigationDestination(for: Film.self) { film in
                FilmDetail(film: film)
            }
        }
    }
}

#Preview {
    WikiView()
}
