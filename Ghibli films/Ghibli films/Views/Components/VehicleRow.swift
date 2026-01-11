//
//  VehicleRow.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 11/1/26.
//

import SwiftUI

struct VehicleRow: View {
    let vehicle: Vehicle
    let allFilms: [Film]
    @State private var isExpanded = false

    var vehicleFilms: [Film] {
        allFilms.filter { film in
            vehicle.films.contains(film.url)
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 12) {
                Image(systemName: "airplane")
                    .vehicleAvatarStyle()

                VStack(alignment: .leading, spacing: 4) {
                    Text(vehicle.name)
                        .font(.headline)

                    HStack(spacing: 8) {
                        if !vehicle.vehicleClass.isEmpty && vehicle.vehicleClass != "NA" {
                            Label(vehicle.vehicleClass, systemImage: "tag")
                                .secondaryTextStyle()
                        }

                        if !vehicle.length.isEmpty && vehicle.length != "NA" {
                            Label("\(vehicle.length)m", systemImage: "ruler")
                                .secondaryTextStyle()
                        }
                    }
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .rotationEffect(.degrees(isExpanded ? 90 : 0))
            }
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isExpanded.toggle()
                }
            }

            if isExpanded {
                VStack(alignment: .leading, spacing: 12) {
                    Divider()

                    if !vehicle.vehicleDescription.isEmpty && vehicle.vehicleDescription != "NA" {
                        Text(vehicle.vehicleDescription)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }

                    if !vehicleFilms.isEmpty {
                        Text("Appears in")
                            .secondaryTextStyle()

                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 8) {
                                ForEach(vehicleFilms) { film in
                                    NavigationLink(destination: FilmDetail(film: film)) {
                                        CachedFilmCard(film: film)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                    }
                }
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .padding(.vertical, 4)
    }
}


#Preview {
    VehicleRow(vehicle: .mock, allFilms: [.mock])
}
