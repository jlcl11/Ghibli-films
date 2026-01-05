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
            ToolbarItemGroup(placement: .bottomBar) {
                Button(action: {}) {
                    Label("Watched", systemImage: film.isWatched ? "eye.fill" : "eye")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(film.isWatched ? .blue : .secondary, .primary)
                }
                
                Button(action: {}) {
                    Label("Favorite", systemImage: film.isFavorite ? "heart.fill" : "heart")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(film.isFavorite ? .red : .secondary, .primary)
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
