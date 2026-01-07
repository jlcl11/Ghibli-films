//
//  CachedFilmCard.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 7/1/26.
//

import SwiftUI

struct CachedFilmCard: View {
    let film: Film
    @State private var image: UIImage?

    var body: some View {
        VStack(spacing: 10) {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.gray.opacity(0.2))
                    .frame(width: 125, height: 175)
                    .overlay(
                        ProgressView()
                    )
            }
        }
        .onAppear {
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
}

#Preview {
    CachedFilmCard(film: .mock)
}
