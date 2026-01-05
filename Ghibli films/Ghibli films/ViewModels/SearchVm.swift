//
//  SearchVm.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 5/1/26.
//

import SwiftUI

@Observable
final class SearchVM {
    var searchText = ""

    func filterFilms(_ films: [Film]) -> [Film] {
        if searchText.isEmpty {
            return films
        } else {
            return films.filter { film in
                film.title.localizedCaseInsensitiveContains(searchText) ||
                film.originalTitle.localizedCaseInsensitiveContains(searchText) ||
                film.director.localizedCaseInsensitiveContains(searchText) ||
                film.releaseDate.contains(searchText)
            }
        }
    }
}
