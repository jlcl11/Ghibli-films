//
//  FilmsListView.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 5/1/26.
//

import SwiftUI

struct FilmsListView: View {
    @Environment(FilmsViewModel.self) private var filmVM
    
    var body: some View {
        VStack{
            switch filmVM.state {
            case .loading:
                ProgressView()
            case .loaded:
                NavigationStack {
                    
                    List {
                        Section {
                            FilmsCarrousel(featuredFilms: filmVM.featuredFilms)
                        } header: {
                            Text("Top Rated")
                                .font(.headline)
                                .foregroundStyle(.primary)
                                .textCase(nil)
                        }
                        
                        Section {
                            FilmList(films: filmVM.films, isSwipeable: true)
                            
                        } header: {
                            Text("All Films")
                                .font(.headline)
                                .foregroundStyle(.primary)
                                .textCase(nil)
                        }
                        
                    } .listStyle(.plain)
                 
                    
                
                    .navigationTitle("Films")
                    .navigationDestination(for: Film.self) { film in
                        FilmDetail(film: film)
                    }
                }
            case .empty:
                ContentUnavailableView("No employee data",
                                       systemImage: "person",
                                       description: Text("There's no person data yet.\nTry to refresh the data or contact support."))
            }
            

        }.refreshable {
            await filmVM.getFilms()
        }
    }
}

#Preview {
    @Previewable @State var vm = FilmsViewModel()

    FilmsListView().task {
        await vm.getFilms()
    }
}
