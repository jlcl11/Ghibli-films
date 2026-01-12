# Ghibli Films

A modern iOS app for exploring Studio Ghibli's filmography, built with SwiftUI and SwiftData.

## Features

### Films
- Browse all Studio Ghibli films with a featured "Top Rated" carousel
- View detailed film information including director, producer, runtime, and Rotten Tomatoes score
- Mark films as "Watched" or "Favorite"
- Pull-to-refresh to sync latest data from the API

### Search
- Real-time search across film titles, original Japanese titles, directors, and release dates
- Case-insensitive filtering with instant results

### Wiki
- Explore the Ghibli universe with categorized content:
  - **Characters** - People and protagonists from all films
  - **Species** - Different species featured across the movies
  - **Locations** - Iconic places from the Ghibli world
  - **Vehicles** - Memorable machines and transport
- Each wiki entry shows which films it appears in
- Film details show related characters, species, locations, and vehicles

### Saved
- Track your watched films
- Curate your favorites list
- Filter between favorites and watched

### Profile
- Customize your avatar with 50+ emoji options
- Set your username
- Choose your favorite film
- Pick from 8 gradient themes (Sunset, Ocean, Forest, Lavender, Fire, Mint, Rose, Galaxy)

## Technologies

- **SwiftUI** - Declarative UI framework
- **SwiftData** - Modern persistence framework
- **Swift Concurrency** - async/await and actors for thread safety
- **@Observable** - Modern state management

## Architecture

The app follows clean architecture principles:

- **MVVM** pattern with Observable ViewModels
- **Repository Pattern** for network abstraction
- **ModelActor** for thread-safe database operations
- **DTO Pattern** for API response mapping
- **Protocol-Oriented** networking layer

### Key Components

- `DataContainer` - SwiftData operations with upsert logic
- `ImageDownloader` - Actor-based image caching (memory + disk)
- `NetworkRepository` - API communication layer
- Custom `ViewModifier` system for consistent styling

## Data Source

Data is fetched from the [Ghibli API](https://ghibliapi.vercel.app), including:
- Films with metadata and imagery
- Characters with attributes
- Vehicles, locations, and species

The app supports offline usage with cached data.

## Requirements

- iOS 18.0+
- Xcode 16.0+

## Installation

1. Clone the repository
```bash
git clone https://github.com/yourusername/Ghibli-films.git
```

2. Open `Ghibli films.xcodeproj` in Xcode

3. Build and run on simulator or device

## Project Structure

```
Ghibli films/
├── System/          # App entry point
├── Views/           # SwiftUI views
│   └── Components/  # Reusable UI components
├── ViewModels/      # Observable state management
├── Model/           # SwiftData models
│   └── DTOs/        # API response objects
├── Persistance/     # Database containers
├── Interface/       # Networking layer
├── Repository/      # API abstraction
└── Extensions/      # Styles and utilities
```

## License

This project is for educational purposes. Studio Ghibli and all related properties are trademarks of Studio Ghibli Inc.
