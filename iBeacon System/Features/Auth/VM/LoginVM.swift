//
//  LoginVM.swift
//  iBeacon System
//
//  Created by Ellan Esenaliev on 3/31/20.
//  Copyright © 2020 Anastasiya Ussenko. All rights reserved.
//

import Foundation
import FirebaseFunctions
import FirebaseAuth
import ObjectMapper

protocol LoginVMDelegate: class {
    func loginVM(didLoadUser user: User)
    func loginVM(didRecieveError message: String)
    func loginVM(didChange state: LoadingState)
}

class LoginVM {
    
    weak var delegate: LoginVMDelegate?
    
    func getUser(uuid: String) {
        Functions.functions().httpsCallable("getUser").call { [weak self]  (result, error) in
            guard let self = self else { return }
            
            if let error = error {
                self.delegate?.loginVM(didRecieveError: error.localizedDescription)
            } else if let json = result?.data as? [String: Any], let user = Mapper<User>().map(JSON: json) {
                self.delegate?.loginVM(didLoadUser: user)
            }
        }
    }
    
    func auth(email: String, password: String) {
        
        guard isValidEmail(email) else {
            delegate?.loginVM(didRecieveError: "Email is not valid!")
            return
        }
        
        guard !password.isEmpty else {
            delegate?.loginVM(didRecieveError: "Password field is empty")
            return
        }
        
        delegate?.loginVM(didChange: .overlay)
        
        Auth.auth().signIn(withEmail: email, password: password) {  [weak self] authResult, error in
            guard self != nil else { return }
            self?.delegate?.loginVM(didChange: .idle)
            if let error = error {
                self?.delegate?.loginVM(didRecieveError: error.localizedDescription)
            } else {
                self?.getUser(uuid: Auth.auth().currentUser!.uid)
            }
        }
    }
    
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
