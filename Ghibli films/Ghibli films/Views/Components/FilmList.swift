//
//  FilmList.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 5/1/26.
//

import SwiftUI

struct FilmList: View {
    var films: [Film]
    var isSwipeable: Bool
    
    var body: some View {
        ForEach(films) { film in
            NavigationLink(value: film) {
                FilmRow(film: film, isSwipable: isSwipeable)
            }
            .buttonStyle(.plain)
        }    }
}

#Preview {
    FilmList(films: [.mock, .mock ], isSwipeable: true)
}
