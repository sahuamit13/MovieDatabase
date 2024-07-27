//
//  MovieDatabaseModelController.swift
//  MovieDatabase
//
//  Created by Amit Sahu on 26/07/24.
//

import UIKit

class MovieDatabaseModelController: NSObject{
    fileprivate let model = MovieViewModel(networkService: MovieDatabaseNetworkService())
    weak var delegate:MovieDatabaseDelegate?
    
    func loadData(completion: @escaping (Swift.Result<Bool,Error>)->Void){
        self.model.loadMovies(completion: { [weak self] result in
            self?.model.resetFilter()
            completion(result)
        })
        
    }
}

extension MovieDatabaseModelController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.model.movieSections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let movieSection = self.model.movieSections[section]
        return movieSection.isExpanded ? movieSection.rows.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.model.movieSections[indexPath.section].rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: item.type.cellReuseIdentifier, for: indexPath)
        if let cell = cell as? MovieFilterOptionTableViewCell{
            cell.loadData(title: item.type.value)
            
            return cell
        }else if let cell = cell as? MovieTableViewCell{
            if let movie = item.type.movie{
                cell.loadData(movieTitle: movie.title, MovieLanguage: movie.language, movieYear: movie.year, posterUrl: movie.poster)
            }
           
            return cell
        }
        
        return cell
    }
    
}
extension MovieDatabaseModelController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.model.movieSections[indexPath.section].rows[indexPath.row]
        switch item.type{
        case .allMovies(let movie),.searchResults(let movie):
            self.delegate?.showMovieDetails(movie: movie)
        case .year(let value),.genre(let value),.director(let value),.actor(let value):
            let movies = self.model.getMovies(for: item.type)
            self.delegate?.showMovieList(title: value, movies: movies)
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: MovieSectionHeaderView.ReuseIdentifier) as! MovieSectionHeaderView
        let movieSection = self.model.movieSections[section]
        headerView.loadData(with: section, title: movieSection.title, isExpanded: movieSection.isExpanded) { [weak self] section in
            if movieSection.isResult == false{
                self?.headerTapped(inSection: section)
            }
        }

        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = self.model.movieSections[indexPath.section].rows[indexPath.row]
        return item.type.height
    }
}
extension MovieDatabaseModelController {
    func headerTapped(inSection section: Int) {
       let movieSection = self.model.movieSections[section]
        movieSection.isExpanded.toggle()
        self.delegate?.reloadData(animation: true)
    }
}
extension MovieDatabaseModelController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            self.model.resetFilter()
        }else{
            self.model.filterMovies(by: searchText)
        }
        self.delegate?.reloadData(animation: false)
    }
}
