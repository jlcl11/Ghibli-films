//
//  FilmViewModel.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 5/1/26.
//

import SwiftUI

enum ViewState {
    case loading
    case loaded
    case empty
}

@Observable
final class FilmsViewModel {
    let repository: NetworkRepository
    
    var films: [Film] = []
    var searchText: String = ""
    var state: ViewState = .loading
    var showError: Bool = false
    var errorMsg: String = ""
    
    var displayedFilms: [Film] {
        films.filter { film in
            if !searchText.isEmpty {
                let searchInTitle = film.title.localizedStandardContains(searchText)
                let searchInOriginalTitle = film.originalTitle.localizedStandardContains(searchText)
                let searchInDescription = film.description.localizedStandardContains(searchText)
                let searchInDirector = film.director.localizedStandardContains(searchText)
                
                guard searchInTitle || searchInOriginalTitle || searchInDescription || searchInDirector else {
                    return false
                }
            }
            
            return true
        }
    }
    
    var featuredFilms: [Film] {
        films.sorted(by: { $0.rtScore > $1.rtScore }).prefix(5).map { $0 }
    }
    
    init(repository: NetworkRepository = Network()) {
        self.repository = repository
    }
    
    @MainActor
    func getFilms() async {
        
        guard films.isEmpty else { return }
        
        state = .loading
        
        do {
            let fetchedFilms = try await repository.getFilms()
            films = fetchedFilms
            state = fetchedFilms.isEmpty ? .empty : .loaded
        } catch {
            errorMsg = "Error loading films: \(error.localizedDescription)"
            showError = true
            state = .empty
        }
    }
    
    func clearSearch() {
        searchText = ""
    }
}

