//
//  UIViewController+Additions.swift
//  MovieDatabase
//
//  Created by Amit Sahu on 27/07/24.
//

import UIKit

extension UIViewController{
    func showAlert(title: String, message: String){
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertViewController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alertViewController, animated: true, completion: nil)
    }
}
