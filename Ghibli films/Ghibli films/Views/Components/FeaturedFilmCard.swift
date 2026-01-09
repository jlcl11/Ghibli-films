//
//  FeaturedFilmCard.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 5/1/26.
//

import SwiftUI

struct FeaturedFilmCard: View {
    let film: Film
    @State private var image: UIImage?

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .featuredImageStyle()
                    .featuredGradientOverlay()
            } else {
                ProgressView()
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(film.title)
                    .filmTitleStyle()

                Text(film.director)
                    .filmSubtitleStyle()

                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .ratingStarStyle(size: .caption2)

                    Text("\(film.rtScore)%")
                        .ratingScoreStyle(size: .caption2, color: .white)
                }
            }
            .padding(12)
        }
        .featuredCardStyle()
        .onAppear {
            guard let banner = film.movieBanner else { return }
            do {
                let file = ImageDownloader.shared.getFileURL(url: banner)
                if FileManager.default.fileExists(atPath: file.path()) {
                    let data = try Data(contentsOf: file)
                    image = UIImage(data: data)
                } else {
                    Task {
                        do {
                            image = try await ImageDownloader.shared.image(for: banner)
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
}

#Preview {
    FeaturedFilmCard(film: .mock)
}
