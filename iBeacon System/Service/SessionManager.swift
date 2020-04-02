//
//  SessionManager.swift
//  iBeacon System
//
//  Created by Anastasiya Ussenko on 3/31/20.
//  Copyright © 2020 Anastasiya Ussenko. All rights reserved.
//

import Foundation
import Firebase
import ObjectMapper

class SessionManager {
    
    static let shared = SessionManager()
    
    private init() {
        if let json = UserDefaults.standard.value(forKey: "user") as? [String: Any] {
            user = Mapper<User>().map(JSON: json)
        }
    }
    
    private var user: User?
    
    func isAuth() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    func getUser() -> User? {
        return user
    }
    
    func set(_ user: User) {
        self.user = user
        UserDefaults.standard.set(user.toJSON(), forKey: "user")
    }
    
    func removeSession() {
        UserDefaults.standard.removeObject(forKey: "user")
    }
}
