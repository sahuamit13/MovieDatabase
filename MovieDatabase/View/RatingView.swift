//
//  RatingView.swift
//  MovieDatabase
//
//  Created by Amit Sahu on 27/07/24.
//

import UIKit

class RatingView: UIView {
    private let segmentedControl: UISegmentedControl
    private let ratingLabel: UILabel
    
    var ratings: [Rating]? {
        didSet {
            self.updateRating()
        }
    }
    
    override init(frame: CGRect) {
        self.segmentedControl = UISegmentedControl()
        self.ratingLabel = UILabel()
        super.init(frame: frame)
        
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        self.segmentedControl = UISegmentedControl(items: ["IMDB", "Rotten Tomatoes", "Metacritic"])
        self.ratingLabel = UILabel()
        super.init(coder: coder)
        
        self.setupView()
    }
    private func insertItems(){
        self.segmentedControl.removeAllSegments()
        RatingSource.allCases.forEach{source in
            self.segmentedControl.insertSegment(withTitle: source.displayName, at: source.rawValue, animated: false)
        }
    }
    private func setupView() {
        self.segmentedControl.selectedSegmentIndex = 0
        self.segmentedControl.addTarget(self, action: #selector(self.ratingSourceChanged), for: .valueChanged)
        
        self.ratingLabel.textAlignment = .center
        
        let stackView = UIStackView(arrangedSubviews: [self.segmentedControl, self.ratingLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        self.updateRating()
    }
    
    @objc private func ratingSourceChanged() {
        self.updateRating()
    }
    
    private func updateRating() {
        guard let ratings = self.ratings, ratings.isEmpty == false else {
            ratingLabel.text = "No rating available"
            return
        }
        
        let selectedIndex = self.segmentedControl.selectedSegmentIndex
        let ratingSource = RatingSource(rawValue: selectedIndex)?.predicate ?? ""
        
        if let rating = self.ratings?.first(where: { $0.source == ratingSource }) {
            self.ratingLabel.text = rating.value
        } else {
            self.ratingLabel.text = "No rating available"
        }
    }
}
