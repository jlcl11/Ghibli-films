# SwiftData Implementation Guide - TrantorBooks

## Table of Contents
1. [Overview](#overview)
2. [Architecture](#architecture)
3. [Data Models](#data-models)
4. [Network Layer](#network-layer)
5. [Data Container - The Bridge](#data-container---the-bridge)
6. [App Initialization](#app-initialization)
7. [View Integration](#view-integration)
8. [Data Flow](#data-flow)
9. [Best Practices & Patterns](#best-practices--patterns)
10. [Complete Code Reference](#complete-code-reference)

---

## Overview

TrantorBooks implements a modern SwiftData architecture that seamlessly integrates with a remote REST API. The app demonstrates professional patterns for:

- **Persistent local storage** using SwiftData
- **Network synchronization** with remote API
- **Concurrent data operations** using Swift actors
- **Type-safe queries** with Swift macros
- **Efficient data updates** using upsert patterns
- **Clean separation** between DTOs and persistent models

### Key Technologies
- SwiftData (persistence framework)
- Swift Concurrency (async/await, actors)
- URLSession (network layer)
- SwiftUI (UI framework with @Query integration)

---

## Architecture

The application follows a layered architecture with clear separation of concerns:

```
┌─────────────────────────────────────────────────────┐
│                   SwiftUI Views                     │
│              (@Query, @Environment)                 │
└──────────────────┬──────────────────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────────────────┐
│              SwiftData Models                       │
│           (Book, Author - @Model)                   │
└──────────────────┬──────────────────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────────────────┐
│            DataContainer (@ModelActor)              │
│         • Upsert Logic                              │
│         • Data Transformation                       │
│         • Concurrent Operations                     │
└──────────────────┬──────────────────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────────────────┐
│          Network Layer (DTOs)                       │
│         NetworkRepository                           │
└──────────────────┬──────────────────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────────────────┐
│            Remote REST API                          │
│   https://trantorapi-acacademy.herokuapp.com/api    │
└─────────────────────────────────────────────────────┘
```

---

## Data Models

### SwiftData Models (`Model.swift`)

The application defines two core SwiftData models with a one-to-many relationship.

#### Book Model

```swift
@Model
final class Book {
    #Index<Book>([\.title], [\.isbn])
    @Attribute(.unique) var id: Int
    var title: String
    @Relationship var author: Author
    var price: Double
    var rating: Double
    var year: Int
    var summary: String?
    var plot: String?
    var pages: Int
    var isbn: String?
    var cover: URL?

    init(id: Int, title: String, author: Author, price: Double,
         rating: Double, year: Int, summary: String?, plot: String?,
         pages: Int, isbn: String?, cover: URL?) {
        self.id = id
        self.title = title
        self.author = author
        self.price = price
        self.rating = rating
        self.year = year
        self.summary = summary
        self.plot = plot
        self.pages = pages
        self.isbn = isbn
        self.cover = cover
    }
}
```

**Key Features:**
- **@Model macro**: Transforms the class into a SwiftData model with automatic persistence
- **@Attribute(.unique)**: Ensures the `id` field is unique (constraint violation throws error)
- **@Relationship**: Establishes a relationship with the Author model
- **#Index**: Creates a composite index on title and ISBN for optimized queries
- **Optional properties**: Fields like `summary`, `plot`, `isbn`, and `cover` can be nil

**Computed Properties:**
```swift
extension Book {
    var priceS: String {
        price.formatted(.currency(code: "usd"))
    }

    var ratingS: String {
        rating.formatted(.number.precision(.integerAndFractionLength(integer: 1, fraction: 2)))
    }
}
```

These extensions provide formatted string representations without storing redundant data.

#### Author Model

```swift
@Model
final class Author {
    @Attribute(.unique) var id: UUID
    var name: String

    @Relationship(deleteRule: .cascade, inverse: \Book.author)
    var books: [Book]

    init(id: UUID, name: String) {
        self.id = id
        self.name = name
        self.books = []
    }
}
```

**Key Features:**
- **UUID identifier**: Uses UUID instead of Int for unique identification
- **Cascade delete rule**: When an author is deleted, all their books are automatically deleted
- **Inverse relationship**: Explicitly defines the bidirectional relationship with `\Book.author`
- **One-to-many relationship**: An author can have multiple books

### Relationship Diagram

```
Author (1) ──────< (Many) Book
   │                      │
   │                      └─ @Relationship var author: Author
   │
   └─ @Relationship(deleteRule: .cascade,
                    inverse: \Book.author)
      var books: [Book]
```

---

## Network Layer

### API Endpoints (`URL.swift`)

```swift
let api = URL(string: "https://trantorapi-acacademy.herokuapp.com/api")!

extension URL {
    static let getAuthors = api.appending(path: "/books/authors")
    static let getBooks = api.appending(path: "/books/latest")
    static func findBooks(search: String) -> URL {
        api.appending(path: "/books/find").appending(path: search)
    }
}
```

**Available Endpoints:**
1. `GET /books/authors` - Fetch all authors
2. `GET /books/latest` - Fetch latest books
3. `GET /books/find/{search}` - Search for books by query

### Data Transfer Objects (`ModelDTO.swift`)

DTOs serve as the contract between the network layer and the persistence layer.

```swift
struct BookDTO: Codable, Identifiable {
    let id: Int
    let title: String
    let author: UUID        // References author by UUID
    let price: Double
    let rating: Double?     // Optional (may be null in API)
    let summary: String?
    let pages: Int?
    let plot, isbn: String?
    let cover: String?      // URL as string
}

struct AuthorsDTO: Codable {
    let id: UUID
    let name: String
}
```

**Key Design Choices:**
- **Codable protocol**: Automatic JSON encoding/decoding
- **Identifiable protocol**: Enables use in SwiftUI ForEach
- **Optional fields**: Match API contract where some fields may be missing
- **Author reference**: Books reference authors by UUID, not embedded object
- **Cover as String**: API returns URL as string, converted to URL in SwiftData model

### Network Repository (`NetworkRepository.swift`)

```swift
struct NetworkRepository: NetworkInteractor {
    func getLatestBooks() async throws -> [BookDTO] {
        try await getJSON(.get(url: .getBooks), type: [BookDTO].self)
    }

    func getAuthors() async throws -> [AuthorsDTO] {
        try await getJSON(.get(url: .getAuthors), type: [AuthorsDTO].self)
    }

    func findBooks(search: String) async throws -> [BookDTO] {
        try await getJSON(.get(url: .findBooks(search: search)), type: [BookDTO].self)
    }
}
```

**Pattern Details:**
- **Protocol conformance**: Implements `NetworkInteractor` from NetworkAPI module
- **Async/await**: All network calls are asynchronous
- **Type-safe**: Explicitly defines return types
- **Error propagation**: Uses `throws` to propagate network/decoding errors

---

## Data Container - The Bridge

The `DataContainer` is the heart of the data synchronization system. It bridges the gap between network DTOs and SwiftData models.

### Actor-Based Concurrency (`DataContainer.swift`)

```swift
@ModelActor
actor DataContainer {
    private let network = NetworkRepository()

    func loadInitialData() async throws {
        let (books, authors) = try await getBooksAndAuthors()
        try loadAuthors(authors: authors)
        try loadBooks(books: books)
    }
}
```

**@ModelActor Benefits:**
- **Thread safety**: Actor isolation prevents data races
- **Automatic modelContext**: The macro provides `modelContext` property
- **Background execution**: Operations run off the main thread
- **Structured concurrency**: Integrates with Swift's async/await

### Parallel Network Fetching

```swift
func getBooksAndAuthors() async throws -> ([BookDTO], [AuthorsDTO]) {
    async let getAuthors = network.getAuthors()
    async let getBooks = network.getLatestBooks()
    return try await (getBooks, getAuthors)
}
```

**Performance Optimization:**
- **Concurrent requests**: Both API calls execute simultaneously
- **async let**: Creates child tasks that run in parallel
- **Tuple return**: Waits for both to complete before returning
- **Error handling**: If either fails, both are cancelled

### Author Upsert Logic

```swift
func loadAuthors(authors: [AuthorsDTO]) throws {
    for author in authors {
        let id = author.id
        let fetch = FetchDescriptor<Author>(predicate: #Predicate { $0.id == id })
        let query = try modelContext.fetchCount(fetch)
        if query == 0 {
            let newAuthor = Author(id: author.id, name: author.name)
            modelContext.insert(newAuthor)
        }
    }
    if modelContext.hasChanges {
        try modelContext.save()
    }
}
```

**Step-by-step Breakdown:**

1. **Iterate through DTOs**: Process each author from the network
2. **Create FetchDescriptor**: Type-safe query descriptor
3. **Use Swift Predicate Macro**: `#Predicate { $0.id == id }` is type-checked at compile time
4. **Check existence**: `fetchCount` returns 0 if author doesn't exist
5. **Insert if new**: Only create new authors (no updates for authors)
6. **Batch save**: Check `hasChanges` before saving (performance optimization)

**Why no updates for authors?**
Authors only have `name`, which rarely changes. This is an intentional design choice to avoid unnecessary writes.

### Book Upsert Logic (Insert or Update)

```swift
func loadBooks(books: [BookDTO]) throws {
    for book in books {
        // Step 1: Find the author
        let id = book.author
        var fetch = FetchDescriptor<Author>(predicate: #Predicate { $0.id == id })
        fetch.fetchLimit = 1
        let query = try modelContext.fetch(fetch)
        guard let author = query.first else { continue }

        // Step 2: Check if book exists
        let bookID = book.id
        var fetchBooks = FetchDescriptor<Book>(predicate: #Predicate { $0.id == bookID })
        fetchBooks.fetchLimit = 1
        let queryBooks = try modelContext.fetch(fetchBooks)

        // Step 3: Update or Insert
        if let foundBook = queryBooks.first {
            // UPDATE existing book
            foundBook.title = book.title
            foundBook.author = author
            foundBook.price = book.price
            foundBook.rating = book.rating ?? 0
            foundBook.year = book.year
            foundBook.summary = book.summary
            foundBook.plot = book.plot
            foundBook.pages = book.pages ?? 0
            foundBook.isbn = book.isbn
            foundBook.cover = URL(string: book.cover ?? "")
        } else {
            // INSERT new book
            let newBook = Book(id: book.id,
                               title: book.title,
                               author: author,
                               price: book.price,
                               rating: book.rating ?? 0,
                               year: book.year,
                               summary: book.summary,
                               plot: book.plot,
                               pages: book.pages ?? 0,
                               isbn: book.isbn,
                               cover: URL(string: book.cover ?? ""))
            modelContext.insert(newBook)
        }
    }
    if modelContext.hasChanges {
        try modelContext.save()
    }
}
```

**Detailed Workflow:**

1. **Resolve author relationship**:
   - Extract author UUID from BookDTO
   - Query SwiftData for matching Author
   - Skip book if author doesn't exist (`guard` statement)
   - Set `fetchLimit = 1` for performance (stop after first match)

2. **Check book existence**:
   - Query by book ID
   - Returns existing Book object or nil

3. **Upsert decision**:
   - **Update path**: Modify all properties of existing book
   - **Insert path**: Create new Book instance and insert

4. **Save optimization**:
   - Only call `save()` if there are actual changes
   - Batch all changes in one save operation

**Important Details:**
- **Optional handling**: `book.rating ?? 0` provides default when API returns null
- **URL conversion**: `URL(string: book.cover ?? "")` converts string to URL (may be nil)
- **Reference integrity**: Books always reference valid authors
- **Idempotent**: Running multiple times produces same result

---

## App Initialization

### Application Entry Point (`TrantorBooksApp.swift`)

```swift
@main
struct TrantorBooksApp: App {
    var body: some Scene {
        WindowGroup {
            MainTab()
        }
        .modelContainer(for: Book.self) { result in
            guard case .success(let container) = result else {
                return
            }
            Task.detached(priority: .high) {
                let modelContainer = DataContainer(modelContainer: container)
                do {
                    try await modelContainer.loadInitialData()
                } catch {
                    print(error)
                }
            }
        }
    }
}
```

**Initialization Flow:**

1. **ModelContainer creation**:
   ```swift
   .modelContainer(for: Book.self)
   ```
   - Creates persistent container for Book model
   - Automatically includes Author (due to relationship)
   - Uses default configuration (SQLite storage)

2. **Success handling**:
   ```swift
   guard case .success(let container) = result else { return }
   ```
   - Pattern match on Result type
   - Early exit if container creation fails

3. **Background data loading**:
   ```swift
   Task.detached(priority: .high) {
       let modelContainer = DataContainer(modelContainer: container)
       try await modelContainer.loadInitialData()
   }
   ```
   - **Task.detached**: Creates unstructured task (survives parent cancellation)
   - **priority: .high**: Prioritizes data loading
   - **Async execution**: UI doesn't block while loading
   - **Error handling**: Prints errors but doesn't crash app

**Why Task.detached?**
- Regular `Task` would be tied to the view's lifetime
- `Task.detached` ensures completion even if view disappears
- High priority ensures data loads quickly on app launch

---

## View Integration

SwiftData provides seamless SwiftUI integration through property wrappers.

### ContentView - Basic @Query Usage

```swift
struct ContentView: View {
    @Environment(\.modelContext) var context
    @Query private var books: [Book]
    @Namespace private var namespace

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(books) { book in
                        NavigationLink(value: book) {
                            BookRow(book: book, namespace: namespace)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .navigationDestination(for: Book.self) { book in
                BookView(book: book, namespace: namespace)
            }
        }
        .refreshable {
            let modelContainer = DataContainer(modelContainer: context.container)
            Task.detached {
                do {
                    try await modelContainer.loadInitialData()
                } catch {
                    print(error)
                }
            }
        }
    }
}
```

**Key Integration Points:**

1. **@Environment(\.modelContext)**:
   - Provides access to the ModelContext
   - Automatically injected by `.modelContainer()` modifier
   - Used for manual operations (refresh)

2. **@Query**:
   ```swift
   @Query private var books: [Book]
   ```
   - Automatically fetches all books
   - Updates view when data changes
   - No boilerplate code needed
   - Sorted by default (insertion order)

3. **Pull-to-refresh**:
   ```swift
   .refreshable {
       let modelContainer = DataContainer(modelContainer: context.container)
       Task.detached {
           try await modelContainer.loadInitialData()
       }
   }
   ```
   - Creates new DataContainer with current context
   - Re-syncs with API
   - Updates happen automatically via @Query

### ListByAuthor - Relationship Navigation

```swift
struct ListByAuthor: View {
    @Query private var authors: [Author]
    @Namespace private var namespace

    var body: some View {
        NavigationStack {
            List {
                ForEach(authors) { author in
                    if author.books.count > 0 {
                        Section {
                            ForEach(author.books) { book in
                                NavigationLink(value: book) {
                                    BookRow(book: book, namespace: namespace)
                                }
                                .buttonStyle(.plain)
                            }
                        } header: {
                            Text(author.name)
                                .font(.headline)
                        }
                    }
                }
            }
        }
    }
}
```

**Relationship Traversal:**
- **@Query fetches authors**: `@Query private var authors: [Author]`
- **Access books via relationship**: `author.books`
- **No manual joins**: SwiftData handles relationship loading
- **Automatic filtering**: Only shows authors with books (`if author.books.count > 0`)

**Performance Note:**
SwiftData lazily loads relationships by default, but in this case, the entire relationship is accessed, so all books are loaded.

### Advanced @Query Features

While not used in this project, @Query supports:

```swift
// Sorting
@Query(sort: \Book.title) private var books: [Book]

// Filtering
@Query(filter: #Predicate<Book> { $0.rating > 4.0 }) private var topBooks: [Book]

// Multiple sorts
@Query(sort: [
    SortDescriptor(\Book.year, order: .reverse),
    SortDescriptor(\Book.title)
]) private var sortedBooks: [Book]

// Animations
@Query(animation: .default) private var books: [Book]
```

---

## Data Flow

### Complete Data Flow Diagram

```
┌──────────────────────────────────────────────────────────────┐
│                        App Launch                            │
└────────────────────────────┬─────────────────────────────────┘
                             │
                             ▼
┌──────────────────────────────────────────────────────────────┐
│  TrantorBooksApp.modelContainer(for: Book.self)              │
│  • Creates ModelContainer (SQLite)                           │
│  • Injects modelContext into environment                     │
└────────────────────────────┬─────────────────────────────────┘
                             │
                             ▼
┌──────────────────────────────────────────────────────────────┐
│  Task.detached { DataContainer.loadInitialData() }           │
└────────────────────────────┬─────────────────────────────────┘
                             │
                             ▼
┌──────────────────────────────────────────────────────────────┐
│  DataContainer.getBooksAndAuthors()                          │
│  ┌─────────────────────┐  ┌─────────────────────┐            │
│  │ async let authors   │  │ async let books     │            │
│  │ = getAuthors()      │  │ = getLatestBooks()  │            │
│  └──────────┬──────────┘  └──────────┬──────────┘            │
│             │                        │                       │
│             ▼                        ▼                       │
│  ┌─────────────────────┐  ┌─────────────────────┐            │
│  │ GET /books/authors  │  │ GET /books/latest   │            │
│  └──────────┬──────────┘  └──────────┬──────────┘            │
│             │                        │                       │
│             ▼                        ▼                       │
│  ┌─────────────────────┐  ┌─────────────────────┐            │
│  │ [AuthorsDTO]        │  │ [BookDTO]           │            │
│  └──────────┬──────────┘  └──────────┬──────────┘            │
└─────────────┼─────────────────────────┼──────────────────────┘
              │                         │
              ▼                         │
┌──────────────────────────────────────────────────────────────┐
│  DataContainer.loadAuthors(authors)                          │
│  For each author:                                            │
│    • FetchDescriptor<Author>(predicate: { $0.id == id })     │
│    • If not exists: insert new Author                        │
│  • modelContext.save()                                       │
└────────────────────────────┬─────────────────────────────────┘
                             │
                             ▼
┌──────────────────────────────────────────────────────────────┐
│  DataContainer.loadBooks(books)                              │
│  For each book:                                              │
│    1. Find Author by UUID                                    │
│    2. FetchDescriptor<Book>(predicate: { $0.id == bookID })  │
│    3. If exists: UPDATE all properties                       │
│       Else: INSERT new Book                                  │
│  • modelContext.save()                                       │
└────────────────────────────┬─────────────────────────────────┘
                             │
                             ▼
┌──────────────────────────────────────────────────────────────┐
│                    SwiftData SQLite Store                    │
│  • Books persisted                                           │
│  • Authors persisted                                         │
│  • Relationships maintained                                  │
└────────────────────────────┬─────────────────────────────────┘
                             │
                             ▼
┌──────────────────────────────────────────────────────────────┐
│                     Views Auto-Update                        │
│  • ContentView @Query detects changes                        │
│  • ListByAuthor @Query detects changes                       │
│  • UI re-renders with new data                               │
└──────────────────────────────────────────────────────────────┘
```

### Pull-to-Refresh Flow

```
User pulls down ContentView
         │
         ▼
.refreshable closure triggered
         │
         ▼
Create DataContainer(modelContainer: context.container)
         │
         ▼
Task.detached { loadInitialData() }
         │
         ▼
[Same flow as app launch]
         │
         ▼
@Query automatically re-fetches
         │
         ▼
View updates with new data
```

---

## Best Practices & Patterns

### 1. Separation of Concerns

**DTOs vs Models:**
```
BookDTO (Network)          Book (SwiftData)
├─ author: UUID      →     ├─ author: Author
├─ cover: String?    →     ├─ cover: URL?
└─ Codable                 └─ @Model
```

Benefits:
- Network contract changes don't affect persistence
- Type safety at each layer
- Clear transformation point

### 2. Actor-Based Data Management

```swift
@ModelActor
actor DataContainer {
    // Thread-safe by default
    // modelContext automatically provided
}
```

Benefits:
- Prevents data races
- Explicit async boundaries
- Actor isolation for database operations

### 3. Upsert Pattern

Instead of:
```swift
// ❌ Bad: Delete and re-insert
modelContext.delete(existingBook)
modelContext.insert(newBook)
```

Do:
```swift
// ✅ Good: Update in place
if let existingBook = queryBooks.first {
    existingBook.title = book.title
    existingBook.price = book.price
    // ... update other properties
}
```

Benefits:
- Preserves object identity
- Maintains relationships
- More efficient
- Better for SwiftUI observation

### 4. Batch Saves

```swift
// Process all items
for item in items {
    // ... modifications
}

// Single save at the end
if modelContext.hasChanges {
    try modelContext.save()
}
```

Benefits:
- Reduces I/O operations
- Better performance
- Atomic transactions

### 5. FetchDescriptor with Predicates

```swift
// ✅ Type-safe, modern
let fetch = FetchDescriptor<Book>(
    predicate: #Predicate { $0.id == bookID }
)

// ❌ Old NSPredicate style (avoid)
let predicate = NSPredicate(format: "id == %@", bookID)
```

Benefits:
- Compile-time type checking
- Autocomplete support
- Refactoring-safe

### 6. Relationship Management

```swift
@Relationship(deleteRule: .cascade, inverse: \Book.author)
var books: [Book]
```

Benefits:
- Automatic cascade deletes
- Bidirectional consistency
- SwiftData manages the relationship

### 7. Optional Handling

```swift
// Provide sensible defaults
rating: book.rating ?? 0
pages: book.pages ?? 0

// Allow nullability where appropriate
cover: URL(string: book.cover ?? "")  // Can be nil
```

### 8. Task Priority Management

```swift
Task.detached(priority: .high) {
    // Critical data loading
}
```

Use priorities wisely:
- `.high`: Initial data load, user-initiated refresh
- `.medium`: Background sync
- `.low`: Pre-fetching, caching

### 9. Error Handling

```swift
do {
    try await modelContainer.loadInitialData()
} catch {
    print(error)  // Log for debugging
    // Don't crash the app
}
```

For production:
- Log to analytics service
- Show user-friendly error messages
- Implement retry logic

### 10. Preview Support

Always provide preview containers for SwiftUI previews:

```swift
#Preview(traits: .sampleData) {
    ContentView()
}
```

This enables:
- Fast iteration
- Isolated testing
- No network dependencies

---

## Complete Code Reference

### File Structure

```
TrantorBooks/
├── System/
│   └── TrantorBooksApp.swift          # App entry, ModelContainer setup
├── DataModel/
│   ├── Model.swift                    # Book & Author @Model classes
│   ├── DataContainer.swift            # @ModelActor, upsert logic
│   ├── PreviewContainer.swift         # Preview configuration
│   └── PreviewData.swift              # Sample data
├── Model/
│   └── ModelDTO.swift                 # BookDTO & AuthorsDTO
├── Network/
│   ├── NetworkRepository.swift        # API calls
│   └── URL.swift                      # Endpoint definitions
├── Views/
│   ├── ContentView.swift              # Books list (@Query)
│   ├── ListByAuthor.swift             # Authors grouped view
│   ├── BookView.swift                 # Detail view
│   └── Components/
│       └── BookRow.swift              # List item view
└── ViewModel/
    └── SearchVM.swift                 # Search logic
```

### Key Files Summary

| File | Purpose | Key Technologies |
|------|---------|------------------|
| `Model.swift` | SwiftData models | @Model, @Relationship, #Index |
| `DataContainer.swift` | Data sync logic | @ModelActor, FetchDescriptor |
| `ModelDTO.swift` | Network contracts | Codable, Identifiable |
| `NetworkRepository.swift` | API client | async/await, NetworkInteractor |
| `TrantorBooksApp.swift` | App initialization | .modelContainer, Task.detached |
| `ContentView.swift` | Main books list | @Query, @Environment |
| `ListByAuthor.swift` | Grouped by author | @Query, relationship traversal |

---

## Advanced Patterns

### Custom Queries in Views

```swift
struct TopRatedBooks: View {
    @Query(
        filter: #Predicate<Book> { $0.rating >= 4.5 },
        sort: [SortDescriptor(\Book.rating, order: .reverse)]
    )
    private var topBooks: [Book]

    var body: some View {
        List(topBooks) { book in
            BookRow(book: book)
        }
    }
}
```

### Dynamic Queries

```swift
struct FilteredBooks: View {
    let minYear: Int

    init(minYear: Int) {
        self.minYear = minYear
        _books = Query(filter: #Predicate<Book> { book in
            book.year >= minYear
        })
    }

    @Query private var books: [Book]

    var body: some View {
        List(books) { book in
            Text(book.title)
        }
    }
}
```

### Manual Context Operations

```swift
struct BookEditor: View {
    @Environment(\.modelContext) private var modelContext
    let book: Book

    func updateRating(_ newRating: Double) {
        book.rating = newRating

        // Explicit save
        try? modelContext.save()
    }

    func deleteBook() {
        modelContext.delete(book)
        try? modelContext.save()
    }
}
```

### Transaction Rollback

```swift
func updateBooks(with updates: [BookUpdate]) throws {
    // Begin implicit transaction
    for update in updates {
        let book = try fetchBook(id: update.id)
        book.price = update.newPrice
    }

    do {
        try modelContext.save()  // Commit transaction
    } catch {
        modelContext.rollback()  // Undo all changes
        throw error
    }
}
```

---

## Performance Considerations

### 1. Index Usage

The `#Index<Book>([\.title], [\.isbn])` improves query performance:

```swift
// Fast - uses index
let books = try modelContext.fetch(
    FetchDescriptor<Book>(predicate: #Predicate { $0.title == "Dune" })
)

// Slower - no index on author name
let books = try modelContext.fetch(
    FetchDescriptor<Book>(predicate: #Predicate {
        $0.author.name == "Frank Herbert"
    })
)
```

### 2. Fetch Limits

Always set limits when you only need one result:

```swift
var fetch = FetchDescriptor<Author>(predicate: #Predicate { $0.id == id })
fetch.fetchLimit = 1  // Stop after finding first match
```

### 3. Relationship Loading

SwiftData uses faulting for relationships:

```swift
// Relationship loaded on first access
let authorName = book.author.name  // Database query here

// Subsequent accesses are cached
let authorId = book.author.id  // No query
```

### 4. Batch Operations

```swift
// ✅ Efficient - one save
for book in books {
    book.rating += 0.1
}
try modelContext.save()

// ❌ Inefficient - N saves
for book in books {
    book.rating += 0.1
    try modelContext.save()  // Don't do this!
}
```

---

## Conclusion

This implementation demonstrates a production-ready SwiftData architecture with:

✅ Clean separation between network and persistence layers
✅ Type-safe queries using Swift macros
✅ Actor-based concurrency for thread safety
✅ Efficient upsert pattern for data synchronization
✅ Proper relationship management with cascade rules
✅ SwiftUI integration with @Query and @Environment
✅ Pull-to-refresh with background data loading
✅ Preview support for rapid development

The architecture is scalable, maintainable, and follows modern Swift best practices.

---

## Additional Resources

- [SwiftData Documentation](https://developer.apple.com/documentation/swiftdata)
- [Predicate Macro](https://developer.apple.com/documentation/foundation/predicate)
- [Swift Concurrency](https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html)
- [ModelActor](https://developer.apple.com/documentation/swiftdata/modelactor)
- [FetchDescriptor](https://developer.apple.com/documentation/swiftdata/fetchdescriptor)

---

**Document Version:** 1.0
**Last Updated:** January 2026
**Project:** TrantorBooks
**SwiftData Version:** iOS 17.0+
