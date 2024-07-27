//
//  MovieTableViewCell.swift
//  MovieDatabase
//
//  Created by Amit Sahu on 26/07/24.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieYearLabel: UILabel!
    @IBOutlet weak var movieLanguageLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.movieImageView?.image = nil
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func loadData(movieTitle: String, MovieLanguage: String, movieYear: String, posterUrl: String){
        self.movieTitleLabel?.text = movieTitle
        self.movieLanguageLabel?.text = MovieLanguage
        self.movieYearLabel?.text = movieYear
        self.movieImageView?.downloadImage(stringURL: posterUrl)
    }
    class var Nib: UINib{
        return UINib(nibName: MovieTableViewCell.className, bundle: nil)
    }
    class var ReuseIdentifier: String{
        return MovieTableViewCell.className
    }
}
