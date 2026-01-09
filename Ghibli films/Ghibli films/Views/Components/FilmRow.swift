//
//  FilmRow.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 5/1/26.
//

import SwiftUI
import SwiftData

struct FilmRow: View {
    let film: Film

    var body: some View {
        NavigationLink(value: film) {
            HStack {
                CachedFilmCard(film: film) {
                    StatusBadges(film: film)
                }
                InfoView(film: film)
                Spacer()
            }
            .padding(.vertical, 10)
        }
    }
}

#Preview {
    FilmRow(film: .mock)
        .modelContainer(for: Film.self)
}
