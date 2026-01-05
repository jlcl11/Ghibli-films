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
            // Banner Image
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 300, height: 180)
                    .clipped()
            } else {
                ProgressView()
            }
            
            // Gradient Overlay
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.black.opacity(0.8),
                    Color.black.opacity(0.4),
                    Color.clear
                ]),
                startPoint: .bottom,
                endPoint: .top
            )
            .frame(width: 300, height: 180)
            
            // Info Overlay
            VStack(alignment: .leading, spacing: 4) {
                Text(film.title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .lineLimit(2)
                
                Text(film.director)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.9))
                
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .font(.caption2)
                        .foregroundStyle(.yellow)
                    
                    Text("\(film.rtScore)%")
                        .font(.caption2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                }
            }
            .padding(12)
        }
        .frame(width: 300, height: 180)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 4)
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
