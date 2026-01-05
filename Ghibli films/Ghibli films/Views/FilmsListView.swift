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
               // EmployeeList(vm: vm)
            case .empty:
                ContentUnavailableView("No employee data",
                                       systemImage: "person",
                                       description: Text("There's no person data yet.\nTry to refresh the data or contact support."))
            }
            

        }
    }
}

#Preview {
    FilmsListView()
}
