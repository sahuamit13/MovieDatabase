//
//  Movie.swift
//  MovieDatabase
//
//  Created by Amit Sahu on 26/07/24.
//

import UIKit

struct Rating: Codable {
    let source: String
    let value: String
    
    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}

struct Movie: Codable {
    let title: String
    let year: String
    let rated: String
    let released: String
    let runtime: String
    let genre: String
    let director: String
    let writer: String
    let actors: String
    let plot: String
    let language: String
    let country: String
    let awards: String
    let poster: String
    let ratings: [Rating]
    let metascore: String
    let imdbRating: String
    let imdbVotes: String
    let imdbId: String
    let type: String
    let dvd: String?
    let boxOffice: String?
    let production: String?
    let website: String?
    let response: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case ratings = "Ratings"
        case metascore = "Metascore"
        case imdbRating = "imdbRating"
        case imdbVotes = "imdbVotes"
        case imdbId = "imdbID"
        case type = "Type"
        case dvd = "DVD"
        case boxOffice = "BoxOffice"
        case production = "Production"
        case website = "Website"
        case response = "Response"
    }
}

enum MovieCellType {
    case year(String)
    case genre(String)
    case director(String)
    case actor(String)
    case allMovies(Movie)
    case searchResults(Movie)
    
    var value: String {
        switch self {
        case .year(let year):
            return year
        case .genre(let genre):
            return genre
        case .director(let director):
            return director
        case .actor(let actor):
            return actor
        default:
            return ""
        }
    }
    var movie: Movie?{
        switch self {
        case .allMovies(let movie), .searchResults(let movie):
            return movie
        default:
            return nil
        }
    }
    var cellReuseIdentifier: String{
        switch self {
        case .allMovies(_),.searchResults(_):
            return MovieTableViewCell.ReuseIdentifier
        default :
            return MovieFilterOptionTableViewCell.ReuseIdentifier
        }
        
    }
    var height: CGFloat{
        switch self {
        case .allMovies(_),.searchResults(_):
            return 110.0
        default :
            return UITableView.automaticDimension
        }
        
    }
}

struct MovieSectionRows {
    var type: MovieCellType
}
class MovieSection{
    var title: String
    var rows: [MovieSectionRows]
    var isExpanded: Bool
    var isResult: Bool
    
    init(title: String, rows: [MovieSectionRows], isExpanded: Bool, isResult: Bool = false) {
        self.title = title
        self.rows = rows
        self.isExpanded = isExpanded
        self.isResult = isResult
    }
}

enum RatingSource: Int, CaseIterable{
    case imdb = 0
    case rottenTomatoes = 1
    case metacritic = 2
    
    var displayName: String{
        switch self {
        case .imdb:
            return "IMDB"
        case .rottenTomatoes:
            return "Rotten Tomatoes"
        case .metacritic:
            return "Metacritic"
        }
    }
    var predicate: String{
        switch self {
        case .imdb:
            return "Internet Movie Database"
        case .rottenTomatoes:
            return "Rotten Tomatoes"
        case .metacritic:
            return "Metacritic"
        }
    }
}
