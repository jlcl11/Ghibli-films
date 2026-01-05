//
//  FilmBannerView.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 5/1/26.
//

import SwiftUI

struct FilmBannerView: View {
    let image: UIImage?

    var body: some View {
        if let image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
        } else {
            Rectangle()
                .foregroundStyle(.gray)
                .aspectRatio(16/9, contentMode: .fit)
                .frame(maxHeight: 300)
        }
    }
}

#Preview {
    FilmBannerView(image: nil)
}
