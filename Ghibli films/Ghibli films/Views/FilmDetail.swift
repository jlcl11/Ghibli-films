//
//  FilmDetail.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 5/1/26.
//

import SwiftUI

struct FilmDetail: View {
    let film: Film
    
    var body: some View {
        Text(film.title)
    }
}

#Preview {
    FilmDetail(film: .mock)
}
