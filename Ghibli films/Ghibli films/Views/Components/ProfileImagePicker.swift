//
//  ProfileImagePicker.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 7/1/26.
//

import SwiftUI
import SwiftData

struct ProfileImagePicker: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @Binding var selectedEmoji: String
    @Binding var selectedGradient: ProfileGradient
    @State private var tempEmoji: String = ""
    @State private var tempGradient: ProfileGradient = .sunset

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                // Preview Section
                VStack(spacing: 16) {
                    Text("Preview")
                        .font(.headline)
                        .foregroundStyle(.secondary)

                    Text(tempEmoji)
                        .font(.system(size: 60))
                        .profileAvatarStyle(gradient: tempGradient.gradient, size: 120)
                }
                .padding(.top, 20)

                // Background Gradient Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Background")
                        .font(.headline)
                        .padding(.horizontal)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(ProfileGradient.allCases) { gradient in
                                Button {
                                    tempGradient = gradient
                                } label: {
                                    Circle()
                                        .fill(gradient.gradient)
                                        .frame(width: 60, height: 60)
                                        .circleSelectionIndicator(isSelected: tempGradient == gradient)
                                        .smallShadow()
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }

                // Emoji Section
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
                                    tempEmoji = emoji
                                } label: {
                                    Text(emoji)
                                        .font(.system(size: 36))
                                        .frame(width: 50, height: 50)
                                        .rectangleSelectionIndicator(isSelected: tempEmoji == emoji)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }

                Spacer()
            }
            .onAppear {
                tempEmoji = selectedEmoji
                tempGradient = selectedGradient
            }
            .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button(role: .cancel) {
                            dismiss()
                        } label: {
                            Label("Cancelar", systemImage: "xmark")
                        }
                    }

                    ToolbarItem(placement: .confirmationAction) {
                        if #available(iOS 26, *) {
                            Button(role: .confirm) {
                                Task {
                                    let container = ProfileDataContainer(modelContainer: modelContext.container)
                                    try? await container.updateProfileAppearance(
                                        emoji: tempEmoji,
                                        gradient: tempGradient.rawValue
                                    )
                                    selectedEmoji = tempEmoji
                                    selectedGradient = tempGradient
                                    dismiss()
                                }
                            } label: {
                                Label("Guardar", systemImage: "checkmark")
                            }
                        } else {
                            Button {
                                Task {
                                    let container = ProfileDataContainer(modelContainer: modelContext.container)
                                    try? await container.updateProfileAppearance(
                                        emoji: tempEmoji,
                                        gradient: tempGradient.rawValue
                                    )
                                    selectedEmoji = tempEmoji
                                    selectedGradient = tempGradient
                                    dismiss()
                                }
                            } label: {
                                Label("Guardar", systemImage: "checkmark")
                            }
                        }
                    }
                }
        }
    }
}

#Preview {
    @Previewable @State var emoji = "😀"
    @Previewable @State var gradient = ProfileGradient.sunset

    ProfileImagePicker(
        selectedEmoji: $emoji,
        selectedGradient: $gradient
    )
}
