//
//  CachedFilmCard.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 7/1/26.
//

import SwiftUI

struct CachedFilmCard<Badge: View>: View {
    let film: Film
    let badge: Badge?
    @State private var image: UIImage?

    init(film: Film, @ViewBuilder badge: () -> Badge) {
        self.film = film
        self.badge = badge()
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .posterStyle(width: 100, height: 150)
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.gray.opacity(0.2))
                    .frame(width: 100, height: 150)
                    .overlay(ProgressView())
            }

            badge
        }
        .onAppear {
            loadImage()
        }
    }

    private func loadImage() {
        guard let imageURL = film.image else { return }
        do {
            let file = ImageDownloader.shared.getFileURL(url: imageURL)
            if FileManager.default.fileExists(atPath: file.path()) {
                let data = try Data(contentsOf: file)
                image = UIImage(data: data)
            } else {
                Task {
                    do {
                        image = try await ImageDownloader.shared.image(for: imageURL)
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

extension CachedFilmCard where Badge == EmptyView {
    init(film: Film) {
        self.film = film
        self.badge = nil
    }
}

#Preview {
    CachedFilmCard(film: .mock)
}
