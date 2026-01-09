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
                PreviewSection(emoji: tempEmoji, gradient: tempGradient)
                GradientPicker(selectedGradient: $tempGradient)
                EmojiPicker(selectedEmoji: $tempEmoji)
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
