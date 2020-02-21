//
//  ViewController.swift
//  iBeacon System
//
//  Created by Anastasiya Ussenko on 2/19/20.
//  Copyright © 2020 Anastasiya Ussenko. All rights reserved.
//

import UIKit
import FirebaseAuth
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapLogout(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            UIView.transition(with: UIApplication.shared.keyWindow!, duration: 0.3, options: .transitionFlipFromLeft, animations: {
                UIApplication.shared.keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
            }, completion: nil)
            
        } catch {
            let alert = UIAlertController(title: "Error", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
}

