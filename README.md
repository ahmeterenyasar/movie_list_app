# Movie List App

A simple Flutter application for browsing popular movies and managing favorites. This app demonstrates clean architecture, SOLID principles, and the use of Cubit (from flutter_bloc), Dio, and SharedPreferences.

## Features

- 📱 **Popular Movies Page**: Browse popular movies from TMDB (The Movie Database)
- 🔍 **Search Movies**: Search for movies by title
- ❤️ **Favorites**: Add/remove movies to/from your favorites list
- 📊 **Pagination**: Infinite scroll to load more movies
- 💾 **Local Storage**: Favorites are saved locally using SharedPreferences

## Architecture

This app follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── main.dart              # App entry point with BlocProvider setup
├── models/                # Data models (Movie, MovieResponse)
├── services/              # API service layer (MovieApiService)
├── repositories/          # Repository pattern (data abstraction)
│   ├── movie_repository.dart
│   └── favorites_repository.dart
├── cubits/               # State management (Cubit pattern)
│   ├── movie_list_cubit.dart
│   └── favorites_cubit.dart
├── screens/              # UI screens
│   ├── movie_list_page.dart
│   └── favorites_page.dart
└── widgets/              # Reusable UI components
    ├── movie_card.dart
    ├── loading_indicator.dart
    └── empty_state.dart
```

### SOLID Principles Implementation

- **Single Responsibility**: Each class has one clear purpose
- **Open-Closed**: Open for extension, closed for modification
- **Liskov Substitution**: Proper inheritance and polymorphism
- **Interface Segregation**: Small, focused interfaces (repository pattern)
- **Dependency Inversion**: Depends on abstractions, not concretions

## Setup Instructions

### 1. Get Your TMDB API Key

1. Go to [https://www.themoviedb.org/settings/api](https://www.themoviedb.org/settings/api)
2. Create an account or log in
3. Request an API key
4. Copy your API key

### 2. Add API Key to the App

1. Open `lib/config/api_config.dart`
2. Replace `YOUR_API_KEY_HERE` with your actual TMDB API key:

```dart
static const String apiKey = 'your_actual_api_key_here';
```

### 3. Install Dependencies

```bash
flutter pub get
```

### 4. Run the App

```bash
flutter run
```

## Technologies Used

- **Flutter**: UI framework
- **flutter_bloc**: State management using Cubit pattern
- **Dio**: HTTP client for API requests
- **SharedPreferences**: Local storage for favorites
- **Equatable**: Value equality for efficient state comparison

## Package Versions

- `flutter_bloc: ^8.1.3`
- `dio: ^5.4.0`
- `shared_preferences: ^2.2.2`
- `equatable: ^2.0.5`

## How to Use

### Movie List Page

1. The app opens with popular movies
2. Scroll down to load more movies (infinite scroll)
3. Tap the search bar to search for specific movies
4. Tap the heart icon on any movie card to add it to favorites
5. Tap the favorites icon in the app bar to view your favorites

### Favorites Page

1. View all your favorited movies
2. Tap the heart icon to remove a movie from favorites
3. Tap the trash icon to clear all favorites

## Code Comments

The code is heavily commented to help you learn:

- **Class-level comments**: Explain the purpose and SOLID principles
- **Method comments**: Describe what each method does
- **Inline comments**: Clarify complex logic
- **SOLID principles**: Explained throughout the codebase

## Learning Points

This app demonstrates:

1. **Cubit Pattern**: State management without needing to handle events
2. **Repository Pattern**: Data abstraction for easy testing
3. **Dependency Injection**: Using BlocProvider for DI
4. **Clean Code**: Well-commented, organized code
5. **SOLID Principles**: Applied throughout the codebase
6. **Async Programming**: Handling API calls and async operations
7. **Local Storage**: Using SharedPreferences for persistence

## Project Structure Benefits

- **Testability**: Clear separation makes unit testing easy
- **Maintainability**: Easy to modify and extend
- **Readability**: Clear organization and naming
- **Scalability**: Easy to add new features

## Notes

- Ensure you have a stable internet connection to load movies
- Favorites are stored locally and persist between app restarts
- The API has rate limits - don't make too many requests
