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
    func mainVM(didEnterTo beacon: Beacon)
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
            Functions.functions().httpsCallable("comeIn").call(["professorID": beacon.professorID]) { (result, error) in
                if let _ = result?.data, error == nil {
                    self.delegate?.mainVM(didEnterTo: beacon)
                }
                self.isProcessing = false
            }
        }
    }
    
    private func getBeacon(from beacon: CLBeacon) -> Beacon?{
        return beacons.filter({ $0.major == beacon.major.intValue &&
            $0.uuid == beacon.uuid.uuidString &&
            $0.minor == beacon.minor.intValue }).first
    }
}