//
//  ProfileDataContainer.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 8/1/26.
//

import Foundation
import SwiftData

@ModelActor
actor ProfileDataContainer {

    /// Get the current profile (there should only be one)
    func getProfile() throws -> Profile? {
        let fetchDescriptor = FetchDescriptor<Profile>()
        let profiles = try modelContext.fetch(fetchDescriptor)
        return profiles.first
    }

    /// Ensure a profile exists (creates one with defaults if needed)
    func ensureProfileExists() throws {
        if try getProfile() != nil {
            return
        }

        let newProfile = Profile(
            userName: "",
            selectedEmoji: "😀",
            selectedGradient: "Sunset",
            favFilm: nil
        )
        modelContext.insert(newProfile)
        try modelContext.save()
    }

    /// Get or create a profile and return it (internal use only)
    private func getOrCreateProfile() throws -> Profile {
        try ensureProfileExists()
        return try getProfile()!
    }

    /// Create or update profile with all properties
    func saveProfile(userName: String, selectedEmoji: String, selectedGradient: String, favFilm: String? = nil) throws {
        // Check if profile already exists
        var fetchProfile = FetchDescriptor<Profile>()
        fetchProfile.fetchLimit = 1
        let existingProfiles = try modelContext.fetch(fetchProfile)

        if let existingProfile = existingProfiles.first {
            // UPDATE existing profile
            existingProfile.userName = userName
            existingProfile.selectedEmoji = selectedEmoji
            existingProfile.selectedGradient = selectedGradient
            existingProfile.favFilm = favFilm
        } else {
            // INSERT new profile
            let newProfile = Profile(
                userName: userName,
                selectedEmoji: selectedEmoji,
                selectedGradient: selectedGradient,
                favFilm: favFilm
            )
            modelContext.insert(newProfile)
        }

        if modelContext.hasChanges {
            try modelContext.save()
        }
    }

    /// Update username
    func updateUserName(_ userName: String) throws {
        let profile = try getOrCreateProfile()
        profile.userName = userName

        if modelContext.hasChanges {
            try modelContext.save()
        }
    }

    /// Update profile appearance (emoji and gradient together)
    func updateProfileAppearance(emoji: String, gradient: String) throws {
        let profile = try getOrCreateProfile()
        profile.selectedEmoji = emoji
        profile.selectedGradient = gradient

        if modelContext.hasChanges {
            try modelContext.save()
        }
    }

    // MARK: - Favorite Film CRUD Operations

    /// Get the current favorite film ID
    func getFavFilm() throws -> String? {
        return try getProfile()?.favFilm
    }

    /// Set a film as the favorite
    func setFavFilm(_ filmID: String) throws {
        let profile = try getOrCreateProfile()
        profile.favFilm = filmID

        if modelContext.hasChanges {
            try modelContext.save()
        }
    }

    /// Remove the favorite film (set to nil)
    func removeFavFilm() throws {
        let profile = try getOrCreateProfile()

        profile.favFilm = nil

        if modelContext.hasChanges {
            try modelContext.save()
        }
    }

    /// Toggle favorite film - if filmID matches current favorite, remove it; otherwise set it
    func toggleFavFilm(_ filmID: String) throws {
        let profile = try getOrCreateProfile()

        if profile.favFilm == filmID {
            profile.favFilm = nil
        } else {
            profile.favFilm = filmID
        }

        if modelContext.hasChanges {
            try modelContext.save()
        }
    }

    /// Delete the current profile
    func deleteProfile() throws {
        guard let profile = try getProfile() else { return }

        modelContext.delete(profile)

        if modelContext.hasChanges {
            try modelContext.save()
        }
    }
}
