//
//  LocationRow.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 11/1/26.
//

import SwiftUI

struct LocationRow: View {
    let location: Location
    let allFilms: [Film]
    @State private var isExpanded = false

    var locationFilms: [Film] {
        allFilms.filter { film in
            location.films.contains(film.url)
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 12) {
                Image(systemName: "map.fill")
                    .locationAvatarStyle()

                VStack(alignment: .leading, spacing: 4) {
                    Text(location.name)
                        .font(.headline)

                    HStack(spacing: 8) {
                        if !location.climate.isEmpty && location.climate != "NA" {
                            Label(location.climate, systemImage: "cloud.sun")
                                .secondaryTextStyle()
                        }

                        if !location.terrain.isEmpty && location.terrain != "NA" {
                            Label(location.terrain, systemImage: "mountain.2")
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

                    VStack(spacing: 8) {
                        if !location.surfaceWater.isEmpty && location.surfaceWater != "NA" {
                            LocationInfoRow(label: "Surface Water", value: "\(location.surfaceWater)%")
                        }
                    }

                    if !locationFilms.isEmpty {
                        Text("Appears in")
                            .secondaryTextStyle()

                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 8) {
                                ForEach(locationFilms) { film in
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

struct LocationInfoRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .metadataLabelStyle()
            Spacer()
            Text(value)
                .metadataValueStyle()
        }
    }
}

#Preview {
    LocationRow(location: .mock, allFilms: [.mock])
}
