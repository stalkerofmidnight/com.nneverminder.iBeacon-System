//
//  NotificationsVC.swift
//  iBeacon System
//
//  Created by Ellan Esenaliev on 3/28/20.
//  Copyright © 2020 Anastasiya Ussenko. All rights reserved.
//

import UIKit

class NotificationsVC: BaseVC {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.backgroundView = NotificationsEmptyView()
            tableView.delegate = self
            tableView.dataSource = self
            tableView.tableFooterView = UIView(frame: .zero)
            tableView.register(NotificationTVCell.nib, forCellReuseIdentifier: NotificationTVCell.identifier)
            tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            tableView.allowsSelection = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension NotificationsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTVCell.identifier) as! NotificationTVCell
        return cell
    }
}

extension NotificationsVC: UITableViewDelegate {
    
}
