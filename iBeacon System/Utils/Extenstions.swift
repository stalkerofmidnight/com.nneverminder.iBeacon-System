//
//  Extenstions.swift
//  iBeacon System
//
//  Created by Anastasiya Ussenko on 3/29/20.
//  Copyright © 2020 Anastasiya Ussenko. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    class var identifier: String {
        return String(describing: self)
    }
}

extension UIViewController {
    
    public func showAlert(with message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
