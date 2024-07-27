//
//  MovieSectionHeaderView.swift
//  MovieDatabase
//
//  Created by Amit Sahu on 26/07/24.
//

import UIKit

class MovieSectionHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var expandCollapseImageView: UIImageView!
    private var section: Int = 0
    var tapAction: ((Int) -> Void)?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setupGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupGestureRecognizer()
    }
    
    func loadData(with section: Int, title: String, isExpanded: Bool, tapAction: @escaping (Int) -> Void ){
        self.titleLabel?.text = title
        self.section = section
        self.tapAction = tapAction
        let systemImage  = isExpanded ? "chevron.down" : "chevron.right"
        self.expandCollapseImageView.image = UIImage(systemName: systemImage)
        
    }
    private func setupGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerTapped))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func headerTapped() {
        self.tapAction?(section)
    }
    
    class var Nib: UINib{
        return UINib(nibName: MovieSectionHeaderView.className, bundle: nil)
    }
    class var ReuseIdentifier: String{
        return MovieSectionHeaderView.className
    }
}
