//
//  FilmDetailComponents.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 5/1/26.
//

import SwiftUI

extension FilmDetail {
   struct BannerView: View {
       let image: UIImage?
       
       var body: some View {
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
       }
   }
   
   
   struct DetailInfo: View {
       let film: Film
       
       var body: some View {
           VStack(alignment: .leading, spacing: 16) {
               TitleSection(title: film.title, originalTitle: film.originalTitle)
               StatsSection(rtScore: film.rtScore, runningTime: film.runningTime)
               CreditsSection(director: film.director, producer: film.producer)
               SynopsisSection(description: film.filmDescription)
               ReleaseInfo(releaseDate: film.releaseDate)
           }
       }
   }
   
   struct TitleSection: View {
       let title: String
       let originalTitle: String
       
       var body: some View {
           VStack(alignment: .leading, spacing: 8) {
               Text(title)
                   .font(.title)
                   .fontWeight(.bold)
               
               if originalTitle != title {
                   Text(originalTitle)
                       .font(.body)
                       .foregroundColor(.secondary)
               }
           }
       }
   }
   
   struct StatsSection: View {
       let rtScore: Int
       let runningTime: Int
       
       var body: some View {
           HStack(spacing: 16) {
               StatItem(icon: "star.fill", color: .yellow, text: "\(rtScore)%")
               StatItem(icon: "clock.fill", color: .blue, text: "\(runningTime) min")
           }
           .font(.subheadline)
       }
   }
   
   struct StatItem: View {
       let icon: String
       let color: Color
       let text: String
       
       var body: some View {
           HStack(spacing: 4) {
               Image(systemName: icon)
                   .foregroundColor(color)
               Text(text)
                   .fontWeight(.semibold)
           }
       }
   }
   
   struct CreditsSection: View {
       let director: String
       let producer: String
       
       var body: some View {
           VStack(alignment: .leading, spacing: 12) {
               CreditItem(label: "Director", name: director)
               CreditItem(label: "Producer", name: producer)
           }
       }
   }
   
   struct CreditItem: View {
       let label: String
       let name: String
       
       var body: some View {
           VStack(alignment: .leading, spacing: 4) {
               Text(label)
                   .font(.subheadline)
                   .foregroundColor(.secondary)
               Text(name)
                   .font(.body)
                   .fontWeight(.medium)
           }
       }
   }
   
   struct SynopsisSection: View {
       let description: String
       
       var body: some View {
           VStack(alignment: .leading, spacing: 8) {
               Text("Synopsis")
                   .font(.headline)
               
               Text(description)
                   .font(.body)
                   .foregroundColor(.secondary)
                   .lineSpacing(4)
           }
       }
   }
   
   struct ReleaseInfo: View {
       let releaseDate: String
       
       var body: some View {
           Text("Release: \(releaseDate)")
               .font(.subheadline)
               .foregroundColor(.secondary)
       }
   }
}
