//
//  FilmDetail.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 5/1/26.
//

import SwiftUI

struct FilmDetail: View {
    let film: Film
    @State private var image: UIImage?
    
    var body: some View {
        
        ScrollView {
            
            //MARK: Image
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
            } else {
                Rectangle()
                    .foregroundStyle(.gray)
                    .aspectRatio(16/9, contentMode: .fit)
                    .frame(maxHeight: 300)
            }
            
            //MARK: Info
            VStack(alignment: .leading, spacing: 16) {
                // Main title
                Text(film.title)
                    .font(.title)
                    .fontWeight(.bold)
                
                // Original title
                if film.originalTitle != film.title {
                    Text(film.originalTitle)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                
                // Statistics: rating and duration
                HStack(spacing: 16) {
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("\(film.rtScore)%")
                            .fontWeight(.semibold)
                    }
                    
                    HStack(spacing: 4) {
                        Image(systemName: "clock.fill")
                            .foregroundColor(.blue)
                        Text("\(film.runningTime) min")
                            .fontWeight(.semibold)
                    }
                }
                .font(.subheadline)
                
                // Director
                VStack(alignment: .leading, spacing: 4) {
                    Text("Director")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text(film.director)
                        .font(.body)
                        .fontWeight(.medium)
                }
                
                // Producer
                VStack(alignment: .leading, spacing: 4) {
                    Text("Producer")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text(film.producer)
                        .font(.body)
                        .fontWeight(.medium)
                }
                
                // Synopsis
                VStack(alignment: .leading, spacing: 8) {
                    Text("Synopsis")
                        .font(.headline)
                    
                    Text(film.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .lineSpacing(4)
                }
                
                // Release date
                Text("Release: \(film.releaseDate)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }.safeAreaPadding()
            
        }.ignoresSafeArea()
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
}
