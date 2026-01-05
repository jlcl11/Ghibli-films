//
//  Ghibli_filmsApp.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 5/1/26.
//

import SwiftUI
import SwiftData

@main
struct Ghibli_filmsApp: App {
    @State private var filmVM = FilmsViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(filmVM)
        }
        .modelContainer(for: Film.self) { result in
            guard case .success(let container) = result else {
                return
            }
            Task.detached(priority: .high) {
                let modelContainer = DataContainer(modelContainer: container)
                do {
                    try await modelContainer.loadInitialData()
                } catch {
                    print("Error loading initial data: \(error)")
                }
            }
        }
    }
}
