//
//  NSObject+Additions.swift
//  MovieDatabase
//
//  Created by Amit Sahu on 27/07/24.
//

import Foundation

extension NSObject{
    class var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
