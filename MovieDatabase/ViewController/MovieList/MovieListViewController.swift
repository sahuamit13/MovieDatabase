//
//  MovieListViewController.swift
//  MovieDatabase
//
//  Created by Amit Sahu on 27/07/24.
//

import UIKit

class MovieListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    fileprivate let modelController = MovieListModelController()
    
    convenience init(title: String, movies: [Movie]) {
        self.init(nibName: MovieListViewController.className, bundle: nil)
        self.modelController.loadData(movies: movies)
        self.title = title
    }
    
    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.modelController.delegate = self
        self.navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
        self.setup()
    }
    
    fileprivate func setup(){
        self.tableView?.dataSource = self.modelController
        self.tableView?.delegate = self.modelController
        self.tableView?.sectionHeaderTopPadding = 0.0
        
        self.tableView?.register(MovieTableViewCell.Nib, forCellReuseIdentifier: MovieTableViewCell.ReuseIdentifier)
    }
}
extension MovieListViewController: MovieDatabaseDelegate{
    func showMovieDetails(movie: Movie) {
        let viewController = MovieDetailsViewController(movie: movie)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
