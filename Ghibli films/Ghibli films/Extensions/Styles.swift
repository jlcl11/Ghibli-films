//
//  Styles.swift
//  Ghibli films
//
//  Created by José Luis Corral López on 8/1/26.
//

import SwiftUI

// MARK: - Shadow Modifiers

struct SmallShadow: ViewModifier {
    func body(content: Content) -> some View {
        content.shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}

struct MediumShadow: ViewModifier {
    func body(content: Content) -> some View {
        content.shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
}

struct FeaturedShadow: ViewModifier {
    func body(content: Content) -> some View {
        content.shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 4)
    }
}

// MARK: - Image Styling Modifiers

struct PosterImageStyle: ViewModifier {
    let width: CGFloat
    let height: CGFloat

    func body(content: Content) -> some View {
        content
            .scaledToFill()
            .frame(width: width, height: height)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .smallShadow()
    }
}

struct FeaturedImageStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .aspectRatio(contentMode: .fill)
            .frame(width: 300, height: 180)
            .clipped()
    }
}

// MARK: - Card Styling Modifiers

struct CardBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct FeaturedCardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 300, height: 180)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .featuredShadow()
    }
}

struct DropdownCardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color(UIColor.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .mediumShadow()
    }
}

// MARK: - Badge Styling Modifiers

struct BadgeStyle: ViewModifier {
    let color: Color

    func body(content: Content) -> some View {
        content
            .font(.caption2)
            .foregroundStyle(.white)
            .padding(4)
            .background(color.opacity(0.8))
            .clipShape(Circle())
    }
}

// MARK: - Text Styling Modifiers

struct SectionHeaderStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundStyle(.primary)
            .textCase(nil)
    }
}

struct SecondaryTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.caption)
            .foregroundStyle(.secondary)
    }
}

struct TertiaryTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.caption2)
            .foregroundStyle(.tertiary)
    }
}

struct FilmTitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .lineLimit(2)
    }
}

struct FilmSubtitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.caption)
            .foregroundStyle(.white.opacity(0.9))
    }
}

// MARK: - Profile Avatar Modifiers

struct ProfileAvatarStyle: ViewModifier {
    let gradient: MeshGradient
    let size: CGFloat

    func body(content: Content) -> some View {
        ZStack {
            Circle()
                .fill(gradient)
                .frame(width: size, height: size)
            content
        }
        .mediumShadow()
    }
}

// MARK: - Scroll Modifiers

struct CarouselScrollStyle: ViewModifier {
    let height: CGFloat

    func body(content: Content) -> some View {
        content
            .scrollTargetBehavior(.viewAligned)
            .scrollClipDisabled()
            .contentMargins(.horizontal, 5, for: .scrollContent)
            .defaultScrollAnchor(.leading)
            .scrollIndicators(.hidden)
            .frame(height: height)
    }
}

struct ClearListRowStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .listRowInsets(EdgeInsets())
            .listRowBackground(Color.clear)
    }
}

// MARK: - Gradient Overlay

struct FeaturedGradientOverlay: ViewModifier {
    func body(content: Content) -> some View {
        content.overlay(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.black.opacity(0.8),
                    Color.black.opacity(0.4),
                    Color.clear
                ]),
                startPoint: .bottom,
                endPoint: .top
            )
        )
    }
}

// MARK: - Metadata Styling Modifiers

struct MetadataLabelStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .foregroundColor(.secondary)
    }
}

struct MetadataValueStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.body)
            .fontWeight(.medium)
    }
}

struct DescriptionTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.body)
            .foregroundColor(.secondary)
            .lineSpacing(4)
    }
}

// MARK: - Rating Styling Modifiers

struct RatingStarStyle: ViewModifier {
    var size: Font = .caption

    func body(content: Content) -> some View {
        content
            .font(size)
            .foregroundStyle(.yellow)
    }
}

struct RatingScoreStyle: ViewModifier {
    var size: Font = .caption
    var color: Color = .primary

    func body(content: Content) -> some View {
        content
            .font(size)
            .fontWeight(.semibold)
            .foregroundStyle(color)
    }
}

// MARK: - Selection Indicator Modifiers

struct CircleSelectionIndicator: ViewModifier {
    let isSelected: Bool

    func body(content: Content) -> some View {
        content.overlay(
            Circle()
                .strokeBorder(
                    isSelected ? Color.blue : Color.clear,
                    lineWidth: 3
                )
        )
    }
}

struct RectangleSelectionIndicator: ViewModifier {
    let isSelected: Bool

    func body(content: Content) -> some View {
        content.overlay(
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(
                    isSelected ? Color.blue : Color.clear,
                    lineWidth: 2
                )
        )
    }
}

// MARK: - View Extensions

extension View {
    // Shadows
    func smallShadow() -> some View {
        modifier(SmallShadow())
    }

    func mediumShadow() -> some View {
        modifier(MediumShadow())
    }

    func featuredShadow() -> some View {
        modifier(FeaturedShadow())
    }

    // Image Styles
    func posterStyle(width: CGFloat = 80, height: CGFloat = 120) -> some View {
        modifier(PosterImageStyle(width: width, height: height))
    }

    func featuredImageStyle() -> some View {
        modifier(FeaturedImageStyle())
    }

    // Card Styles
    func cardBackground() -> some View {
        modifier(CardBackground())
    }

    func featuredCardStyle() -> some View {
        modifier(FeaturedCardStyle())
    }

    func dropdownCardStyle() -> some View {
        modifier(DropdownCardStyle())
    }

    // Badge Style
    func badgeStyle(color: Color) -> some View {
        modifier(BadgeStyle(color: color))
    }

    // Text Styles
    func sectionHeaderStyle() -> some View {
        modifier(SectionHeaderStyle())
    }

    func secondaryTextStyle() -> some View {
        modifier(SecondaryTextStyle())
    }

    func tertiaryTextStyle() -> some View {
        modifier(TertiaryTextStyle())
    }

    func filmTitleStyle() -> some View {
        modifier(FilmTitleStyle())
    }

    func filmSubtitleStyle() -> some View {
        modifier(FilmSubtitleStyle())
    }

    // Profile Avatar
    func profileAvatarStyle(gradient: MeshGradient, size: CGFloat = 100) -> some View {
        modifier(ProfileAvatarStyle(gradient: gradient, size: size))
    }

    // Scroll Styles
    func carouselScrollStyle(height: CGFloat = 180) -> some View {
        modifier(CarouselScrollStyle(height: height))
    }

    func clearListRowStyle() -> some View {
        modifier(ClearListRowStyle())
    }

    // Gradient Overlay
    func featuredGradientOverlay() -> some View {
        modifier(FeaturedGradientOverlay())
    }

    // Selection Indicators
    func circleSelectionIndicator(isSelected: Bool) -> some View {
        modifier(CircleSelectionIndicator(isSelected: isSelected))
    }

    func rectangleSelectionIndicator(isSelected: Bool) -> some View {
        modifier(RectangleSelectionIndicator(isSelected: isSelected))
    }

    // Metadata Styles
    func metadataLabelStyle() -> some View {
        modifier(MetadataLabelStyle())
    }

    func metadataValueStyle() -> some View {
        modifier(MetadataValueStyle())
    }

    func descriptionTextStyle() -> some View {
        modifier(DescriptionTextStyle())
    }

    // Rating Styles
    func ratingStarStyle(size: Font = .caption) -> some View {
        modifier(RatingStarStyle(size: size))
    }

    func ratingScoreStyle(size: Font = .caption, color: Color = .primary) -> some View {
        modifier(RatingScoreStyle(size: size, color: color))
    }
}
