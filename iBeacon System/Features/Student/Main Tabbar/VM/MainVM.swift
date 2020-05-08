//
//  MainVM.swift
//  iBeacon System
//
//  Created by Anastasiya Ussenko on 4/13/20.
//  Copyright © 2020 Anastasiya Ussenko. All rights reserved.
//

import Foundation
import CoreLocation.CLBeaconRegion
import FirebaseFunctions

protocol MainVMDelegate: class {
    func mainVM(didChangeProcessing state: Bool)
    func mainVM(didEnterTo beacon: Beacon, message: String)
}

class MainVM {
    
    weak var delegate: MainVMDelegate?
    
    private var isProcessing: Bool {
        didSet {
            delegate?.mainVM(didChangeProcessing: isProcessing)
        }
    }
    var beacons: [Beacon]
    
    init(user: User) {
        isProcessing = false
        beacons = user.beacons
    }
    
    func comeIn(to beacon: CLBeacon) {
        guard !isProcessing else { return }
        
        isProcessing = true
        if let beacon = getBeacon(from: beacon) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.YYYY"
            
            Functions.functions().httpsCallable("comeIn").call(["professorID": beacon.professorID, "date": dateFormatter.string(from: Date())]) { (result, error) in
                if let json = result?.data as? [String: Any], let message = json["message"] as? String, error == nil {
                    self.delegate?.mainVM(didEnterTo: beacon, message: message)
                }
                self.isProcessing = false
            }
        } else {
            self.isProcessing = false
        }
    }
    
    private func getBeacon(from beacon: CLBeacon) -> Beacon?{
        return beacons.filter({ $0.major == beacon.major.intValue &&
            $0.uuid.uppercased() == beacon.uuid.uuidString &&
            $0.minor == beacon.minor.intValue }).first
    }
}
