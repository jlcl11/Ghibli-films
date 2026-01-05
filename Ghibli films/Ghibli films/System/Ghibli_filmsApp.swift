//
//  Ghibli_filmsApp.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 5/1/26.
//

import SwiftUI

@main
struct Ghibli_filmsApp: App {
    @State private var filmVM = FilmsViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(filmVM)
        }
    }
}
