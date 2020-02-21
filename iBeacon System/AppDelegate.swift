//
//  AppDelegate.swift
//  iBeacon System
//
//  Created by Anastasiya Ussenko on 2/19/20.
//  Copyright © 2020 Anastasiya Ussenko. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        if Auth.auth().currentUser != nil {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
            self.window?.rootViewController = vc
        } else {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
            self.window?.rootViewController = vc
        }
        window?.makeKeyAndVisible()
        
        return true
    }
}

