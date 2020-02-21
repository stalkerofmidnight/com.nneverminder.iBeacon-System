//
//  LoginVC.swift
//  iBeacon System
//
//  Created by Anastasiya Ussenko on 2/21/20.
//  Copyright © 2020 Anastasiya Ussenko. All rights reserved.
//

import UIKit
import FirebaseAuth
import MBProgressHUD

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func didTapLoginButton(_ sender: UIButton) {
        
        guard let email = emailTextField.text, isValidEmail(email) else {
            showErrorAlert(message: "Email is not valid!")
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            showErrorAlert(message: "Password field is empty")
            return
        }
        
        showProgress()
        Auth.auth().signIn(withEmail: email, password: password) {  [weak self] authResult, error in
            guard self != nil else { return }
            self?.hideProgress()
            if let error = error {
                self?.showErrorAlert(message: error.localizedDescription)
            } else {
                UIView.transition(with: UIApplication.shared.keyWindow!, duration: 0.3, options: .transitionFlipFromLeft, animations: {
                    UIApplication.shared.keyWindow?.rootViewController = ViewController()
                }, completion: nil)
            }
        }
    }
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func showProgress() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    func hideProgress() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }

}
