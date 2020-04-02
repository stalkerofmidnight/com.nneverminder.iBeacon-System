//
//  ProfileVM.swift
//  iBeacon System
//
//  Created by Anastasiya Ussenko on 3/31/20.
//  Copyright © 2020 Anastasiya Ussenko. All rights reserved.
//

import Foundation
import ObjectMapper
import FirebaseAuth

protocol ProfileVMDelegate: class {
    func profileVMDidLogOut()
    func profileVM(didRecieveError message: String)
}

class ProfileVM {
    
    weak var delegate: ProfileVMDelegate?
    
    func logout() {
        do {
            try Auth.auth().signOut()
            SessionManager.shared.removeSession()
            delegate?.profileVMDidLogOut()
        } catch {
            delegate?.profileVM(didRecieveError: error.localizedDescription)
        }
    }
}
