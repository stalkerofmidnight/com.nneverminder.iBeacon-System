//
//  ProfileTVC.swift
//  iBeacon System
//
//  Created by Ellan Esenaliev on 3/29/20.
//  Copyright © 2020 Anastasiya Ussenko. All rights reserved.
//

import UIKit
import FirebaseFunctions
class ProfileTVC: UITableViewController {
    
    enum Rows: Int {
        case info
        case logout
    }
    
    @IBOutlet weak var profileImageView: UIImageView! {
        didSet {
            profileImageView.clipsToBounds = true
            profileImageView.layer.cornerRadius = 38
            profileImageView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var profileEmail: UILabel!
    
    var viewModel: ProfileVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ProfileVM()
        viewModel.delegate = self
        profileEmail.text = SessionManager.shared.getUser()!.email
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func showLogoutAlert() {
        let alert = UIAlertController(title: "Are you sure?", message: "Exit?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Exit", style: .destructive, handler: { action in
            self.viewModel.logout()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension ProfileTVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch Rows(rawValue: indexPath.row)! {
            case .info:
                break
            case .logout:
                showLogoutAlert()
        }
    }
}


extension ProfileTVC: ProfileVMDelegate {
    
    func profileVMDidLogOut() {
        UIView.transition(with: UIApplication.shared.windows.first!, duration: 0.3, options: .transitionFlipFromLeft, animations: {
            UIApplication.shared.windows.first?.rootViewController = UIStoryboard(name: "Auth", bundle: nil).instantiateInitialViewController()
        }, completion: nil)
    }
    
    func profileVM(didRecieveError message: String) {
        showAlert(with: message)
    }
}
