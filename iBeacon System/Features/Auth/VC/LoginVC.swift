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
import FirebaseFunctions

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var viewModel: LoginVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = LoginVM()
        viewModel.delegate = self
    }
    
    @IBAction func didTapLoginButton(_ sender: UIButton) {
        
        guard let email = emailTextField.text else { return }
        
        guard let password = passwordTextField.text else { return }
        
        viewModel.auth(email: email, password: password)
    }
}

extension LoginVC: LoginVMDelegate {
    
    func loginVM(didLoadUser user: User) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        guard let window = appDelegate.window else { return }
        
        if user.isProfessor {
            window.rootViewController = UIStoryboard(name: "Professor", bundle: nil).instantiateInitialViewController()
        } else {
            window.rootViewController = UIStoryboard(name: "Student", bundle: nil).instantiateInitialViewController()
        }
        
        UIView.transition(with: window, duration: 0.2, options: .transitionFlipFromLeft, animations: {
            window.makeKeyAndVisible()
        }, completion: nil)
    }
    
    func loginVM(didRecieveError message: String) {
        showAlert(with: message)
    }
    
    func loginVM(didChange state: LoadingState) {
        switch state {
            case .idle:
                MBProgressHUD.hide(for: self.view, animated: true)
            case .overlay:
                MBProgressHUD.showAdded(to: self.view, animated: true)
            default:
                break
        }
    }
}
