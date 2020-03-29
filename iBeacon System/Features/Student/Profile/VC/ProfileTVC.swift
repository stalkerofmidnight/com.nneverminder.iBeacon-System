//
//  ProfileTVC.swift
//  iBeacon System
//
//  Created by Ellan Esenaliev on 3/29/20.
//  Copyright © 2020 Anastasiya Ussenko. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func showLogoutAlert() {
        let alert = UIAlertController(title: "Are you sure?", message: "Exit?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Exit", style: .destructive, handler: { action in
            //TODO: LogOut
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
                break
        }
    }
}
