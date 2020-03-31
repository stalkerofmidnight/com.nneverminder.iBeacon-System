//
//  NotificationsVM.swift
//  iBeacon System
//
//  Created by Ellan Esenaliev on 3/29/20.
//  Copyright © 2020 Anastasiya Ussenko. All rights reserved.
//

import UIKit
import FirebaseFunctions
import ObjectMapper

protocol NotificationsVMDelegate: class {
    func notificationsVM(didLoad notifications: [Notification])
    func notificationsVM(didRecieveError message: String)
    func lognotificationsVMinVM(didChange state: LoadingState)
}

class NotificationsVM {
    
    weak var delegate: NotificationsVMDelegate?
    
    var notifications: [Notification] = []
    
    func getNotifications(state: LoadingState) {
        delegate?.lognotificationsVMinVM(didChange: state)
        Functions.functions().httpsCallable("getNotifications").call { [weak self] (result, error) in
            guard let self = self else { return }
            if let error = error {
                self.delegate?.notificationsVM(didRecieveError: error.localizedDescription)
            } else if let json = result?.data as? [[String: Any]] {
                self.notifications = Mapper<Notification>().mapArray(JSONArray: json)
                self.delegate?.notificationsVM(didLoad: self.notifications)
            }
            self.delegate?.lognotificationsVMinVM(didChange: .idle)
        }
    }
}
