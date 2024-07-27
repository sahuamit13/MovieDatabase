//
//  MovieViewModel.swift
//  MovieDatabase
//
//  Created by Amit Sahu on 26/07/24.
//

import Foundation

class MovieViewModel {
    private var networkService: MovieDatabaseNetworkServiceDelegate?
    private var allMovies = [Movie]()
    private var filterOptions = [MovieSection]()
    var movieSections = [MovieSection]()
    
    init(networkService: MovieDatabaseNetworkServiceDelegate){
        self.networkService = networkService
    }
   
    func prepareSections(searchText: String, filteredMovie: [Movie]){
        self.movieSections.removeAll()
        if searchText.isEmpty{
            self.filterOptions.forEach{$0.isExpanded = false}
            self.movieSections.append(contentsOf: self.filterOptions)
        }else{
            movieSections.append( MovieSection(title: "Search Results", rows: filteredMovie.map { MovieSectionRows(type: .allMovies($0) )}, isExpanded: true, isResult: true ))
        }
        
    }
    
    func loadMovies(completion: @escaping (Swift.Result<Bool,Error>)->Void) {
        self.networkService?.getMovies(completion: {[weak self] result in
            switch result {
            case .success(let movies):
                self?.allMovies = movies.sorted(by: {$0.title < $1.title })
                self?.prepareOptions()
                completion(.success(true))
            case .failure(let error):
                self?.prepareOptions()
                completion(.failure(error))
            }
        })
    }
    private func prepareOptions(){
        let years = Array(Set(allMovies.flatMap { $0.year.components(separatedBy: "–").filter({$0.isEmpty == false}) })).sorted()
        let genres = Array(Set(allMovies.flatMap { $0.genre.components(separatedBy: ", ") })).sorted()
        let directors = Array(Set(allMovies.flatMap { $0.director.components(separatedBy: ", ") })).sorted()
        let actors = Array(Set(allMovies.flatMap { $0.actors.components(separatedBy: ", ") })).sorted()
        
        self.filterOptions.append( MovieSection(title: "Year", rows: years.map { MovieSectionRows(type: .year($0) )}, isExpanded: false ))
        self.filterOptions.append( MovieSection(title: "Genre", rows: genres.map { MovieSectionRows(type: .genre($0) )}, isExpanded: false ))
        self.filterOptions.append( MovieSection(title: "Directors", rows: directors.map { MovieSectionRows(type: .director($0) )}, isExpanded: false ))
        self.filterOptions.append( MovieSection(title: "Actors", rows: actors.map { MovieSectionRows(type: .actor($0) )}, isExpanded: false ))
        self.filterOptions.append( MovieSection(title: "All Movies", rows: allMovies.map { MovieSectionRows(type: .allMovies($0) )}, isExpanded: false ))
        
    }
    
    func filterMovies(by searchText: String) {
        let filteredMovies = allMovies.filter { movie in
            return movie.title.lowercased().contains(searchText.lowercased()) ||
                   movie.genre.lowercased().contains(searchText.lowercased()) ||
                   movie.director.lowercased().contains(searchText.lowercased()) ||
                   movie.actors.lowercased().contains(searchText.lowercased())
        }
        self.prepareSections(searchText: searchText, filteredMovie: filteredMovies)
    }
    
    func resetFilter() {
        self.prepareSections(searchText: "", filteredMovie: [])
    }
    
    func getUniqueValues(for keyPath: KeyPath<Movie, String>) -> [String] {
        let values = allMovies.map { $0[keyPath: keyPath] }
        return Array(Set(values)).sorted()
    }
    
    func getMovies(for keyPath: KeyPath<Movie, String>, value: String) -> [Movie] {
        return allMovies.filter { $0[keyPath: keyPath].localizedCaseInsensitiveContains(value) }
    }
    
    func getMovies(for type: MovieCellType)->[Movie]{
        switch type {
        case .year(let year):
            return getMovies(for: \.year.description, value: year)
        case .genre(let genre):
            return getMovies(for: \.genre.description, value: genre)
        case .director(let director):
            return getMovies(for: \.director.description, value: director)
        case .actor(let actor):
            return getMovies(for: \.actors.description, value: actor)
        default:
            return []
        }
    }
}
