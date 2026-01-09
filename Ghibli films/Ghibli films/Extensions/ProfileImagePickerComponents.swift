//
//  ProfileImagePickerComponents.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 9/1/26.
//

import SwiftUI

extension ProfileImagePicker {
    struct PreviewSection: View {
        let emoji: String
        let gradient: ProfileGradient

        var body: some View {
            VStack(spacing: 16) {
                Text("Preview")
                    .font(.headline)
                    .foregroundStyle(.secondary)

                Text(emoji)
                    .font(.system(size: 60))
                    .profileAvatarStyle(gradient: gradient.gradient, size: 120)
            }
            .padding(.top, 20)
        }
    }

    struct GradientPicker: View {
        @Binding var selectedGradient: ProfileGradient

        var body: some View {
            VStack(alignment: .leading, spacing: 12) {
                Text("Background")
                    .font(.headline)
                    .padding(.horizontal)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(ProfileGradient.allCases) { gradient in
                            Button {
                                selectedGradient = gradient
                            } label: {
                                Circle()
                                    .fill(gradient.gradient)
                                    .frame(width: 60, height: 60)
                                    .circleSelectionIndicator(isSelected: selectedGradient == gradient)
                                    .smallShadow()
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }

    struct EmojiPicker: View {
        @Binding var selectedEmoji: String

        var body: some View {
            VStack(alignment: .leading, spacing: 12) {
                Text("Emoji")
                    .font(.headline)
                    .padding(.horizontal)

                ScrollView {
                    LazyVGrid(
                        columns: [
                            GridItem(.adaptive(minimum: 50, maximum: 60), spacing: 12)
                        ],
                        spacing: 12
                    ) {
                        ForEach(ProfileEmoji.allEmojis, id: \.self) { emoji in
                            Button {
                                selectedEmoji = emoji
                            } label: {
                                Text(emoji)
                                    .font(.system(size: 36))
                                    .frame(width: 50, height: 50)
                                    .rectangleSelectionIndicator(isSelected: selectedEmoji == emoji)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}
