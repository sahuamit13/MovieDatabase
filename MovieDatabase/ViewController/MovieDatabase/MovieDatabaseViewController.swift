//
//  MovieDatabaseViewController.swift
//  MovieDatabase
//
//  Created by Amit Sahu on 26/07/24.
//

import UIKit

class MovieDatabaseViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    fileprivate let modelController = MovieDatabaseModelController()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Movie Database"
        self.setup()
        
        self.modelController.delegate = self
        self.getMovies()
        
    }
    fileprivate func getMovies(){
        self.activityIndicatorView?.startAnimating()
        self.modelController.loadData(completion: { [weak self] result in
            self?.activityIndicatorView.stopAnimating()
            self?.reloadData(animation: false)
            switch result {
            case .success(_):
                break
            case .failure(let error):
                self?.showAlert(title: "Error!", message: error.localizedDescription)
            }
        })
    }
    
    fileprivate func setup(){
        self.searchBar?.delegate = self.modelController
        
        self.tableView?.dataSource = self.modelController
        self.tableView?.delegate = self.modelController
        self.tableView?.sectionHeaderTopPadding = 0.0
        
        self.tableView?.register(MovieTableViewCell.Nib, forCellReuseIdentifier: MovieTableViewCell.ReuseIdentifier)
        self.tableView?.register(MovieFilterOptionTableViewCell.Nib, forCellReuseIdentifier: MovieFilterOptionTableViewCell.ReuseIdentifier)
       
        self.tableView?.register(MovieSectionHeaderView.Nib, forHeaderFooterViewReuseIdentifier: MovieSectionHeaderView.ReuseIdentifier)
       
    }
}
extension MovieDatabaseViewController: MovieDatabaseDelegate{
    func reloadData(animation: Bool) {
        if animation{
            UIView.transition(with: tableView, duration: 0.5, options: .transitionCrossDissolve, animations: {self.tableView?.reloadData()}, completion: nil)
        }else{
            self.tableView?.reloadData()
        }
    }
    func showMovieList(title: String, movies: [Movie]) {
        self.view.endEditing(true)
        let viewController = MovieListViewController(title: title, movies: movies)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showMovieDetails(movie: Movie) {
        self.view.endEditing(true)
        let viewController = MovieDetailsViewController(movie: movie)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
