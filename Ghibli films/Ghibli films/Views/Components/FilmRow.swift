//
//  FilmRow.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 5/1/26.
//

import SwiftUI
import SwiftData

struct FilmRow: View {
    let film: Film
    @State private var image: UIImage?

    var body: some View {
        NavigationLink(value: film) {
            HStack {
                PosterView(film: film, image: image)
                InfoView(film: film)
                Spacer()
            }
            .padding(.vertical, 10)
        }
        .onAppear {
            loadPosterImage()
        }
    }

    // MARK: - Methods
    private func loadPosterImage() {
        guard let poster = film.image else { return }
        do {
            let file = ImageDownloader.shared.getFileURL(url: poster)
            if FileManager.default.fileExists(atPath: file.path()) {
                let data = try Data(contentsOf: file)
                image = UIImage(data: data)
            } else {
                Task {
                    do {
                        image = try await ImageDownloader.shared.image(for: poster)
                    } catch {
                        print(error)
                    }
                }
            }
        } catch {
            print(error)
        }
    }
}

// MARK: - Nested Components
private extension FilmRow {
    struct PosterView: View {
        let film: Film
        let image: UIImage?

        var body: some View {
            ZStack(alignment: .topTrailing) {
                if let image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                } else {
                    ProgressView()
                        .frame(width: 80, height: 120)
                }

                StatusBadges(film: film)
            }
        }
    }

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
                .font(.caption2)
                .foregroundStyle(.white)
                .padding(4)
                .background(color.opacity(0.8))
                .clipShape(Circle())
        }
    }

    struct InfoView: View {
        let film: Film

        var body: some View {
            VStack(alignment: .leading, spacing: 6) {
                Text(film.title)
                    .font(.headline)

                Text(film.originalTitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)

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
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Label(producer, systemImage: "person.fill")
                    .font(.caption)
                    .foregroundStyle(.secondary)
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
            .font(.caption2)
            .foregroundStyle(.tertiary)
        }
    }

    struct RatingView: View {
        let rtScore: Int

        var body: some View {
            HStack(spacing: 4) {
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
                    .font(.caption)

                Text("\(rtScore)%")
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
    FilmRow(film: .mock)
        .modelContainer(for: Film.self)
}
