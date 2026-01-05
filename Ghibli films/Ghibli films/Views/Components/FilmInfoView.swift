//
//  FilmInfoView.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 5/1/26.
//

import SwiftUI

struct FilmInfoView: View {
    let film: Film

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(film.title)
                .font(.headline)

            Text(film.originalTitle)
                .font(.caption)
                .foregroundStyle(.secondary)

            VStack(alignment: .leading, spacing: 2) {
                Label(film.director, systemImage: "film")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Label(film.producer, systemImage: "person.fill")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(.top, 2)

            HStack(spacing: 8) {
                Label(film.releaseDate, systemImage: "calendar")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)

                Label("\(film.runningTime) min", systemImage: "clock")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
            }

            HStack(spacing: 4) {
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
                    .font(.caption)

                Text("\(film.rtScore)%")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)

                Text("IMDB")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            .padding(.top, 4)
        }
    }
}

#Preview {
    FilmInfoView(film: .mock)
        .padding()
}
