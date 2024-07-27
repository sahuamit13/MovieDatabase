# Movie Database App

A Movie Database App built using Swift, employing MVVM architecture and using .xib files, storyboard, and `UIViewController`. The app allows users to search, filter, and view detailed information about movies from a JSON dataset.

## Features

- **Search Functionality**: Search movies by title, genre, actor, or director.
- **Filter Options**: Filter movies by year, genre, directors, and actors.
- **Expandable Sections**: Expand and collapse sections to show related movies.
- **Detailed Movie View**: View detailed information about selected movies, including poster, title, plot, cast & crew, release date, genre, and rating.
- **Custom Rating Control**: Select a rating source (IMDB, Rotten Tomatoes, Metacritic) to view the rating value in a custom UI control.
- **Async Image Loading**: Asynchronously load and display movie posters.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/sahuamit13/MovieDatabase.git
2. Open the project in Xcode:
   ```bash
   cd moviedatabaseapp
   open MovieDatabase.xcodeproj

## Usage

**Main Screen**
**The main screen displays the following filter options:**

 - Year
 - Genre 
 - Directors
 - Actors
 - All Movies
 - Search Results

## Features
1. Browse Movies by Category:
 - Users can browse movies by year, genre, directors, and actors.
 - Each category is displayed in an expandable/collapsible section.

2. Search Functionality:
 - Users can search for movies by title, genre, actor, or director.
 - The search results are displayed dynamically as the user types.

3. Movie Details:
 - Detailed view for each movie, displaying its poster, title, plot, cast & crew, release date, genre, and ratings.
 - Users can select a rating source (IMDB, Rotten Tomatoes, Metacritic) to view the rating value.

4. Custom UI Components:
 - Custom UI control to display the rating value from the selected rating source.
 - Asynchronous loading of movie poster images for a smooth user experience.

5. Technical Details:
 - Architecture: MVVM (Model-View-ViewModel)
 - UI Implementation: Utilizes .xib, storyboard, and UIViewController for UI components.
 - Data Handling: JSON encoder and decoder for loading and parsing movie data.
 - Support Device: iPad and iPhone

## Requirements
 - iOS 15.0+
 - Xcode 12.0+
 - Swift 5.0+
