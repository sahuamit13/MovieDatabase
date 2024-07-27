//
//  MovieFilterOptionTableViewCell.swift
//  MovieDatabase
//
//  Created by Amit Sahu on 26/07/24.
//

import UIKit

class MovieFilterOptionTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func loadData(title: String){
        self.titleLabel?.text = title
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    class var Nib: UINib{
        return UINib(nibName: MovieFilterOptionTableViewCell.className, bundle: nil)
    }
    class var ReuseIdentifier: String{
        return MovieFilterOptionTableViewCell.className
    }
}
