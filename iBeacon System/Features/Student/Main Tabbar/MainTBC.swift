//
//  MainTBC.swift
//  iBeacon System
//
//  Created by Anastasiya Ussenko on 4/12/20.
//  Copyright © 2020 Anastasiya Ussenko. All rights reserved.
//

import UIKit
import CoreLocation
import MBProgressHUD

class MainTBC: UITabBarController {
    
    lazy var locationManage: CLLocationManager = {
        let locationManage = CLLocationManager()
        locationManage.delegate = self
        return locationManage
    }()
    
    var viewModel: MainVM?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = SessionManager.shared.getUser(), !user.isProfessor {
            viewModel = MainVM(user: user)
            viewModel?.delegate = self
            locationManage.requestAlwaysAuthorization()
        }
    }
}

extension MainTBC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }
    
    func startScanning() {
        
        for beacon in self.viewModel?.beacons ?? [] {
            if let uuid = UUID(uuidString: beacon.uuid) {
                let contraint = CLBeaconIdentityConstraint(uuid: uuid, major: CLBeaconMajorValue(beacon.major), minor: CLBeaconMajorValue(beacon.minor))
                let beaconRegion = CLBeaconRegion(beaconIdentityConstraint: contraint, identifier: "Professors")
                
                locationManage.startMonitoring(for: beaconRegion)
                locationManage.startRangingBeacons(satisfying: contraint)
            }
        }
    }
    
    func stopScanning() {
        for beacon in self.viewModel?.beacons ?? [] {
            if let uuid = UUID(uuidString: beacon.uuid) {
                let contraint = CLBeaconIdentityConstraint(uuid: uuid, major: CLBeaconMajorValue(beacon.major), minor: CLBeaconMajorValue(beacon.minor))
                let beaconRegion = CLBeaconRegion(beaconIdentityConstraint: contraint, identifier: "Professors")
                
                locationManage.stopMonitoring(for: beaconRegion)
                locationManage.stopRangingBeacons(satisfying: contraint)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        let nearBeacons = beacons.filter({ $0.proximity == .immediate })
        if let beacon = nearBeacons.first {
            //TODO: Make request to come in!
            viewModel?.comeIn(to: beacon)
        }
    }
}

extension MainTBC: MainVMDelegate {
    
    func mainVM(didEnterTo beacon: Beacon) {
        DispatchQueue.main.async {
            self.showAlert(with: "Success Entered")
            self.stopScanning()
        }
    }
    
    func mainVM(didChangeProcessing state: Bool) {
        DispatchQueue.main.async {
            if state {
                MBProgressHUD.showAdded(to: self.view, animated: true)
            } else {
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        }
    }
}
