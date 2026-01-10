//
//  WikiCategoryRow.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 10/1/26.
//

import SwiftUI

struct WikiCategoryRow: View {
    let icon: String
    let title: String
    let subtitle: String
    let color: Color
    let destination: AnyView

    var body: some View {
        NavigationLink(destination: destination) {
            HStack(spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(color.opacity(0.15))
                        .frame(width: 50, height: 50)

                    Image(systemName: icon)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(color)
                }

                VStack(alignment: .leading, spacing: 3) {
                    Text(title)
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundStyle(.primary)

                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer()
            }
            .padding(.vertical, 4)
        }
    }
}

#Preview {
    WikiCategoryRow(icon: "person.2.fill", title: "Characters", subtitle: "5 characters", color: .blue, destination: AnyView(Text("Hello")))
}
