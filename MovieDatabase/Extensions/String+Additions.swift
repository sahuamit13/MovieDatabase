//
//  String+Additions.swift
//  MovieDatabase
//
//  Created by Amit Sahu on 27/07/24.
//

import Foundation
import UIKit

extension String{
    var isValidURL: Bool {
        
        if let url = URL(string: self) {
            // check if your application can open the NSURL instance
            return UIApplication.shared.canOpenURL(url)
        } else {
            return false
        }
    }
}
