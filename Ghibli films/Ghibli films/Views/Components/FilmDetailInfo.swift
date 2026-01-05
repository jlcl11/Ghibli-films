//
//  FilmDetailInfo.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 5/1/26.
//

import SwiftUI

struct FilmDetailInfo: View {
    let film: Film

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Main title
            Text(film.title)
                .font(.title)
                .fontWeight(.bold)

            // Original title
            if film.originalTitle != film.title {
                Text(film.originalTitle)
                    .font(.body)
                    .foregroundColor(.secondary)
            }

            // Statistics: rating and duration
            HStack(spacing: 16) {
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("\(film.rtScore)%")
                        .fontWeight(.semibold)
                }

                HStack(spacing: 4) {
                    Image(systemName: "clock.fill")
                        .foregroundColor(.blue)
                    Text("\(film.runningTime) min")
                        .fontWeight(.semibold)
                }
            }
            .font(.subheadline)

            // Director
            VStack(alignment: .leading, spacing: 4) {
                Text("Director")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(film.director)
                    .font(.body)
                    .fontWeight(.medium)
            }

            // Producer
            VStack(alignment: .leading, spacing: 4) {
                Text("Producer")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(film.producer)
                    .font(.body)
                    .fontWeight(.medium)
            }

            // Synopsis
            VStack(alignment: .leading, spacing: 8) {
                Text("Synopsis")
                    .font(.headline)

                Text(film.filmDescription)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .lineSpacing(4)
            }

            // Release date
            Text("Release: \(film.releaseDate)")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    FilmDetailInfo(film: .mock)
        .padding()
}
