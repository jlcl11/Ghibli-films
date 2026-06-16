<p align="center">
  <img width="1500" alt="Ghibli Films hero" src="https://github.com/user-attachments/assets/8b748a44-6f01-4f70-af92-81ffd5f77de6" />
</p>

<h1 align="center">
  <br>
  Ghibli Films
  <br>
</h1>

<h3 align="center">A Studio Ghibli explorer built as a Clean Architecture showcase.</h3>

<p align="center">
  <strong>Clean Architecture</strong> &nbsp;·&nbsp; <strong>ModelActor</strong> &nbsp;·&nbsp; <strong>Actor-based caching</strong> &nbsp;·&nbsp; <strong>Protocol-Oriented</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/iOS_18%2B-000000?style=for-the-badge&logo=apple&logoColor=white" alt="iOS 18+">
  <img src="https://img.shields.io/badge/Swift-F05138?style=for-the-badge&logo=swift&logoColor=white" alt="Swift">
  <img src="https://img.shields.io/badge/SwiftUI-007AFF?style=for-the-badge&logo=swift&logoColor=white" alt="SwiftUI">
  <img src="https://img.shields.io/badge/SwiftData-FF9500?style=for-the-badge&logo=swift&logoColor=white" alt="SwiftData">
  <img src="https://img.shields.io/badge/Clean_Architecture-2D2D2D?style=for-the-badge" alt="Clean Architecture">
</p>

---

## What is Ghibli Films

A modern iOS app for exploring Studio Ghibli's filmography — but really, an excuse to put Clean Architecture, `ModelActor`, actor-based image caching and protocol-oriented networking on display in something visual and fun.

Data comes from the open [Ghibli API](https://ghibliapi.vercel.app): films, characters, species, locations and vehicles. Everything is cached locally with SwiftData so the app works offline once you've browsed something.

---

## Features

| | |
|---|---|
| **Films** | Browse all Studio Ghibli films with a "Top Rated" carousel. View director, producer, runtime, Rotten Tomatoes score. Mark as Watched or Favourite. Pull-to-refresh syncs the API. |
| **Search** | Real-time, case-insensitive search across film titles, original Japanese titles, directors and release dates. |
| **Wiki** | Cross-referenced universe: characters, species, locations and vehicles — each entry shows which films it appears in. Film details show their related entities. |
| **Saved** | Watched + Favourites lists with filtering. Persisted with SwiftData via a thread-safe `ModelActor`. |
| **Profile** | Choose from 50+ emoji avatars, set username and favourite film, pick one of 8 gradient themes (Sunset, Ocean, Forest, Lavender, Fire, Mint, Rose, Galaxy). |

---

## Architecture

The app follows Clean Architecture: presentation, domain and data layers communicate through protocols. The database layer is fully isolated behind a `ModelActor`, and image loading runs on a dedicated `Actor` with memory + disk tiers.

```
Ghibli films/
  System/                 App entry point and shared services
  Views/                  SwiftUI screens
    Components/           Reusable cards, rows, modifiers
  ViewModels/             @Observable state holders
  Model/                  SwiftData entities + domain models
    DTOs/                 API response objects
  Persistance/            DataContainer (ModelActor) with upsert logic
  Interface/              URLSession networking layer
  Repository/             Protocol-based API abstraction
  Extensions/             ViewModifier system for consistent styling
```

### Key Components

| Component | Role |
|---|---|
| **DataContainer** | `ModelActor` wrapping SwiftData operations with upsert logic |
| **ImageDownloader** | Actor-based image caching — memory tier + disk tier |
| **NetworkRepository** | Protocol-fronted API client, mockable for tests |
| **ViewModifier system** | Centralised theming and styling primitives |

---

## Quick Start

**Requirements:** Xcode 16+ · iOS 18+ · Swift Concurrency on a Mac with Apple Silicon recommended

```bash
git clone https://github.com/jlcl11/Ghibli-films.git
cd Ghibli-films
open "Ghibli films.xcodeproj"
```

Build and run on a simulator or device.

---

## Tech Stack

| Technology | Role |
|---|---|
| **Swift Concurrency** | async/await, actors and `Sendable` correctness throughout |
| **SwiftUI + @Observable** | Declarative UI with modern reactive state |
| **SwiftData + ModelActor** | Thread-safe local persistence with upsert logic |
| **Repository pattern** | Network and database abstracted behind protocols |
| **Actor-based ImageDownloader** | Memory + disk image cache with isolation guarantees |
| **DTOs** | Clean separation between API responses and domain models |

---

## Data Source

Films, characters, species, locations and vehicles fetched from the [Ghibli API](https://ghibliapi.vercel.app). Imagery and titles are property of Studio Ghibli Inc. and used for educational portfolio purposes only.

---

<p align="center">
  Built by <a href="https://github.com/jlcl11">Jose Luis Corral Lopez</a> · Clean Architecture portfolio sample
</p>
