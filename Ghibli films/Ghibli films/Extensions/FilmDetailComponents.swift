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
                       .metadataLabelStyle()
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
                   .ratingScoreStyle(size: .subheadline)
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
                   .metadataLabelStyle()
               Text(name)
                   .metadataValueStyle()
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
                   .descriptionTextStyle()
           }
       }
   }

   struct ReleaseInfo: View {
       let releaseDate: String

       var body: some View {
           Text("Release: \(releaseDate)")
               .metadataLabelStyle()
       }
   }

   struct RelatedContentSection: View {
       let people: [Person]
       let species: [Species]
       let locations: [Location]
       let vehicles: [Vehicle]

       var hasContent: Bool {
           !people.isEmpty || !species.isEmpty || !locations.isEmpty || !vehicles.isEmpty
       }

       var body: some View {
           if hasContent {
               VStack(alignment: .leading, spacing: 16) {
                   Text("Related Content")
                       .font(.headline)

                   if !people.isEmpty {
                       RelatedCategoryRow(
                           title: "Characters",
                           icon: "person.2.fill",
                           color: .blue,
                           items: people.map { $0.name },
                           destination: PeopleListView()
                       )
                   }

                   if !species.isEmpty {
                       RelatedCategoryRow(
                           title: "Species",
                           icon: "pawprint.fill",
                           color: .purple,
                           items: species.map { $0.name },
                           destination: SpeciesListView()
                       )
                   }

                   if !locations.isEmpty {
                       RelatedCategoryRow(
                           title: "Locations",
                           icon: "map.fill",
                           color: .green,
                           items: locations.map { $0.name },
                           destination: LocationListView()
                       )
                   }

                   if !vehicles.isEmpty {
                       RelatedCategoryRow(
                           title: "Vehicles",
                           icon: "airplane",
                           color: .orange,
                           items: vehicles.map { $0.name },
                           destination: VehicleListView()
                       )
                   }
               }
               .frame(maxWidth: .infinity, alignment: .leading)
               .padding(.top, 8)
               .padding(.bottom, 32)
           }
       }
   }

   struct RelatedCategoryRow<Destination: View>: View {
       let title: String
       let icon: String
       let color: Color
       let items: [String]
       let destination: Destination

       var body: some View {
           VStack(alignment: .leading, spacing: 8) {
               HStack(spacing: 8) {
                   Image(systemName: icon)
                       .font(.subheadline)
                       .foregroundStyle(color)
                   Text(title)
                       .font(.subheadline)
                       .fontWeight(.medium)
               }

               VStack(alignment: .leading, spacing: 8) {
                   ForEach(items, id: \.self) { item in
                       NavigationLink(destination: destination) {
                           RelatedItemChip(name: item, color: color)
                       }
                       .buttonStyle(.plain)
                   }
               }
           }
       }
   }

   struct RelatedItemChip: View {
       let name: String
       let color: Color

       var body: some View {
           Text(name)
               .font(.caption)
               .fontWeight(.medium)
               .foregroundStyle(color)
               .padding(.horizontal, 12)
               .padding(.vertical, 8)
               .background(color.opacity(0.15))
               .clipShape(RoundedRectangle(cornerRadius: 16))
       }
   }
}
