//
//  FilmRowComponents.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 9/1/26.
//

import SwiftUI

extension FilmRow {
    struct StatusBadges: View {
        let film: Film

        var body: some View {
            HStack(spacing: 4) {
                if film.isWatched {
                    Badge(icon: "eye.fill", color: .blue)
                }
                if film.isFavorite {
                    Badge(icon: "heart.fill", color: .red)
                }
            }
            .padding(4)
        }
    }

    struct Badge: View {
        let icon: String
        let color: Color

        var body: some View {
            Image(systemName: icon)
                .badgeStyle(color: color)
        }
    }

    struct InfoView: View {
        let film: Film

        var body: some View {
            VStack(alignment: .leading, spacing: 6) {
                Text(film.title)
                    .font(.headline)

                Text(film.originalTitle)
                    .secondaryTextStyle()

                CreditsView(director: film.director, producer: film.producer)
                MetadataView(releaseDate: film.releaseDate, runningTime: film.runningTime)
                RatingView(rtScore: film.rtScore)
            }
        }
    }

    struct CreditsView: View {
        let director: String
        let producer: String

        var body: some View {
            VStack(alignment: .leading, spacing: 2) {
                Label(director, systemImage: "film")
                    .secondaryTextStyle()

                Label(producer, systemImage: "person.fill")
                    .secondaryTextStyle()
            }
            .padding(.top, 2)
        }
    }

    struct MetadataView: View {
        let releaseDate: String
        let runningTime: Int

        var body: some View {
            HStack(spacing: 8) {
                Label(releaseDate, systemImage: "calendar")
                Label("\(runningTime) min", systemImage: "clock")
            }
            .tertiaryTextStyle()
        }
    }

    struct RatingView: View {
        let rtScore: Int

        var body: some View {
            HStack(spacing: 4) {
                Image(systemName: "star.fill")
                    .ratingStarStyle()

                Text("\(rtScore)%")
                    .ratingScoreStyle()

                Text("IMDB")
                    .tertiaryTextStyle()
            }
            .padding(.top, 4)
        }
    }
}
