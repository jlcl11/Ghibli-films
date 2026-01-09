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
                    .metadataLabelStyle()
            }

            // Statistics: rating and duration
            HStack(spacing: 16) {
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .ratingStarStyle(size: .subheadline)
                    Text("\(film.rtScore)%")
                        .ratingScoreStyle(size: .subheadline)
                }

                HStack(spacing: 4) {
                    Image(systemName: "clock.fill")
                        .foregroundColor(.blue)
                    Text("\(film.runningTime) min")
                        .ratingScoreStyle(size: .subheadline)
                }
            }

            // Director
            VStack(alignment: .leading, spacing: 4) {
                Text("Director")
                    .metadataLabelStyle()
                Text(film.director)
                    .metadataValueStyle()
            }

            // Producer
            VStack(alignment: .leading, spacing: 4) {
                Text("Producer")
                    .metadataLabelStyle()
                Text(film.producer)
                    .metadataValueStyle()
            }

            // Synopsis
            VStack(alignment: .leading, spacing: 8) {
                Text("Synopsis")
                    .font(.headline)

                Text(film.filmDescription)
                    .descriptionTextStyle()
            }

            // Release date
            Text("Release: \(film.releaseDate)")
                .metadataLabelStyle()
        }
    }
}

#Preview {
    FilmDetailInfo(film: .mock)
        .padding()
}
