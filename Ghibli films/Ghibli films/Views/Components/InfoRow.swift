//
//  InfoRow.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 10/1/26.
//

import SwiftUI

struct InfoRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .metadataLabelStyle()
            Spacer()
            Text(value.isEmpty || value == "NA" ? "Unknown" : value)
                .metadataValueStyle()
        }
    }
}


#Preview {
    InfoRow(label: "Gender", value: "Female")
}
