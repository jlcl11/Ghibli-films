//
//  WikiCategoryListView.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 11/1/26.
//

import SwiftUI

struct WikiCategoryListView<Content: View>: View {
    let category: WikiCategory
    let isEmpty: Bool
    @ViewBuilder let content: () -> Content

    var body: some View {
        if isEmpty {
            ContentUnavailableView(
                category.emptyTitle,
                systemImage: category.emptyIcon,
                description: Text(category.emptyDescription)
            )
        } else {
            List {
                content()
            }
            .listStyle(.plain)
            .navigationTitle(category.title)
        }
    }
}

#Preview {
    NavigationStack {
        WikiCategoryListView(category: .characters, isEmpty: false) {
            Text("Sample Row 1")
            Text("Sample Row 2")
        }
    }
}
