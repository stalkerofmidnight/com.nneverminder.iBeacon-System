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
        setupNotifications(for: application)
        window = UIWindow(frame: UIScreen.main.bounds)
        if let user = SessionManager.shared.getUser() {
            if user.isProfessor {
                let vc = UIStoryboard(name: "Professor", bundle: nil).instantiateInitialViewController()
                self.window?.rootViewController = vc
            } else {
                let vc = UIStoryboard(name: "Student", bundle: nil).instantiateInitialViewController()
                self.window?.rootViewController = vc
            }
        } else {
            let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateInitialViewController()
            self.window?.rootViewController = vc
        }
        window?.makeKeyAndVisible()
        
        return true
    }
    
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func setupNotifications(for application: UIApplication) {
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: {_, _ in
            
        })
        application.registerForRemoteNotifications()
        
        Messaging.messaging().delegate = self
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        
    }
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("qsdasdad")
    }
}
