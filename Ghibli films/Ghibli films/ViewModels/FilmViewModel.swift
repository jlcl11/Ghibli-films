//
//  FilmViewModel.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 5/1/26.
//

import SwiftUI
import SwiftData

enum ViewState {
    case loading
    case loaded
    case empty
}

@Observable
final class FilmsViewModel {
    var showError: Bool = false
    var errorMsg: String = ""

    init() {}

    /// Refresh data from API and sync with SwiftData
    @MainActor
    func refreshFilms(modelContext: ModelContext) async {
        let dataContainer = DataContainer(modelContainer: modelContext.container)
        do {
            try await dataContainer.loadInitialData()
        } catch {
            errorMsg = "Error refreshing films: \(error.localizedDescription)"
            showError = true
        }
    }
}

