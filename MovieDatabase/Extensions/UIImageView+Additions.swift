//
//  UIImageView+Additions.swift
//  MovieDatabase
//
//  Created by Amit Sahu on 27/07/24.
//

import UIKit

extension UIImageView{
    func downloadImage(stringURL: String) {
        guard  stringURL.isValidURL,let url = URL(string: stringURL) else {
            self.backgroundColor = .lightGray
            return 
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil, let image = UIImage(data: data) else {
                DispatchQueue.main.async { [weak self] in
                    self?.backgroundColor = .lightGray
                }
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.image = image
                self?.backgroundColor = .clear
            }
        }
        task.resume()
    }
}
