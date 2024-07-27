//
//  MovieDetailsViewController.swift
//  MovieDatabase
//
//  Created by Amit Sahu on 27/07/24.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    @IBOutlet weak var castAndCrewLabel: UILabel!
    @IBOutlet weak var releasedDateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var ratingView: RatingView!
    
    fileprivate var movie: Movie?
    
    convenience init(movie: Movie) {
        self.init(nibName: MovieDetailsViewController.className, bundle: nil)
        self.movie = movie
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
        self.title = self.movie?.title
        self.navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
        self.configureView()
    }
    
    fileprivate func configureView(){
        guard let movie = self.movie else { return }
        
        self.posterImageView?.downloadImage(stringURL: movie.poster)
        self.movieNameLabel?.text = movie.title
        self.plotLabel?.text = movie.plot
        self.castAndCrewLabel?.text = movie.actors
        self.releasedDateLabel?.text = movie.released
        self.genreLabel?.text = movie.genre
        self.ratingView.ratings = movie.ratings
        
    }

}
