//
//  MovieListModelController.swift
//  MovieDatabase
//
//  Created by Amit Sahu on 27/07/24.
//

import UIKit

class MovieListModelController: NSObject{
    fileprivate var movies = [Movie]()
    weak var delegate: MovieDatabaseDelegate?
    func loadData(movies: [Movie]){
        self.movies = movies
    }
}

extension MovieListModelController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.ReuseIdentifier, for: indexPath) as! MovieTableViewCell
        let movie = self.movies[indexPath.row]
        cell.loadData(movieTitle: movie.title, MovieLanguage: movie.language, movieYear: movie.year, posterUrl: movie.poster)
        
        return cell
    }
    
}
extension MovieListModelController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = self.movies[indexPath.row]
        self.delegate?.showMovieDetails(movie: movie)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.0
    }
}
