//
//  FilmDetail.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 5/1/26.
//

import SwiftUI
import SwiftData

struct FilmDetail: View {
    let film: Film
    @State private var image: UIImage?
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        ScrollView {
            BannerView(image: image)
            DetailInfo(film: film)
                .safeAreaPadding()
        }
        .ignoresSafeArea()
        .toolbar {
            ToolbarItemGroup() {
                Button {
                    let container = DataContainer(modelContainer: modelContext.container)
                    Task {
                        try? await container.toggleWatched(filmID: film.id)
                    }
                } label: {
                    Label("Watched", systemImage: film.isWatched ? "eye.fill" : "eye")
                }

                Button {
                    let container = DataContainer(modelContainer: modelContext.container)
                    Task {
                        try? await container.toggleFavorite(filmID: film.id)
                    }
                } label: {
                    Label("Favorite", systemImage: film.isFavorite ? "heart.fill" : "heart")
                }
            }
        }
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
    FilmDetail(film: .mock)
        .modelContainer(for: Film.self)
}
