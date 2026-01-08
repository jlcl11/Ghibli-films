//
//  FilmCategoryRow.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 8/1/26.
//

import SwiftUI

struct FilmCategoryRow: View {
    let films: [Film]
    let title: String
    let icon: String
    let iconColor: Color
    let emptyStateIcon: String
    let emptyStateMessage: String
    
    var body: some View {
        NavigationLink {
            FilmsGridView(
                films: films,
                title: title,
                emptyStateIcon: emptyStateIcon,
                emptyStateMessage: emptyStateMessage
            )
        } label: {
            VStack {
                HStack {
                    Label(title, systemImage: icon)
                        .foregroundStyle(iconColor)
                        .fontWeight(.semibold)
                    Spacer()
                    Text("\(films.count)")
                }
                
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(films) { film in
                            CachedFilmCard(film: film)
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    FilmCategoryRow(
        films: [.mock, .mock],
        title: "Favorite Films",
        icon: "heart.fill",
        iconColor: .red,
        emptyStateIcon: "heart.slash",
        emptyStateMessage: "Add films to favorites to see them here"
    )
}
