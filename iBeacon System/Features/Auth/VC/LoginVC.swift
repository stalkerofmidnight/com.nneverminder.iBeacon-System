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
        UIView.transition(with: UIApplication.shared.windows.first!, duration: 0.3, options: .transitionFlipFromLeft, animations: {
            UIApplication.shared.windows.first!.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
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
