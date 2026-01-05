//
//  FilmRow.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 5/1/26.
//

import SwiftUI

struct FilmRow: View {
    let film: Film
    var isSwipable: Bool
    @State private var image: UIImage?
    
    var body: some View {
        NavigationLink(value: film) {
            HStack {
                //MARK: Image
                if let image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                } else {
                    ProgressView()
                }
                
                //MARK: Info
                VStack(alignment: .leading, spacing: 6) {
                    
                    Text(film.title)
                        .font(.headline)
                    
                    Text(film.originalTitle)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Label(film.director, systemImage: "film")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        Label(film.producer, systemImage: "person.fill")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.top, 2)
                    
                    HStack(spacing: 8) {
                        Label(film.releaseDate, systemImage: "calendar")
                            .font(.caption2)
                            .foregroundStyle(.tertiary)
                        
                        Label("\(film.runningTime) min", systemImage: "clock")
                            .font(.caption2)
                            .foregroundStyle(.tertiary)
                    }
                    
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                            .font(.caption)
                        
                        Text("\(film.rtScore)%")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(.primary)
                        
                        Text("IMDB")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.top, 4)
                }
                
                Spacer()
            }
            .padding(.vertical, 10)
            //TODO: SwipeActions
            
            .onAppear {
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
    }
}

#Preview {
    FilmRow(film: .mock, isSwipable: true)
}
