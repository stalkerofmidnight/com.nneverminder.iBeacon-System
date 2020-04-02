//
//  NotificationsVC.swift
//  iBeacon System
//
//  Created by Anastasiya Ussenko on 3/28/20.
//  Copyright © 2020 Anastasiya Ussenko. All rights reserved.
//

import UIKit
import MBProgressHUD

class NotificationsVC: BaseVC {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.tableFooterView = UIView(frame: .zero)
            tableView.register(NotificationTVCell.nib, forCellReuseIdentifier: NotificationTVCell.identifier)
            tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            tableView.allowsSelection = false
        }
    }
    
    lazy var emptyView: NotificationsEmptyView = {
        let view = NotificationsEmptyView(name: SessionManager.shared.getUser()!.name)
        return view
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let conrol = UIRefreshControl()
        conrol.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        return conrol
    }()
    
    var viewModel: NotificationsVM = NotificationsVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.getNotifications(state: .overlay)
    }
}

extension NotificationsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if viewModel.notifications.count == 0 {
            tableView.backgroundView = emptyView
        } else {
            tableView.backgroundView = nil
        }
        
        return viewModel.notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTVCell.identifier) as! NotificationTVCell
        let notification = viewModel.notifications[indexPath.row]
        cell.dateLabel.text = notification.getStringDate()
        cell.contentLabel.text = notification.text
        return cell
    }
    
    @objc private func refresh() {
        viewModel.getNotifications(state: .refresh)
    }
}

extension NotificationsVC: UITableViewDelegate {
    
}

extension NotificationsVC: NotificationsVMDelegate {
    func notificationsVM(didLoad notifications: [Notification]) {
        tableView.reloadData()
    }
    
    func notificationsVM(didRecieveError message: String) {
        showAlert(with: message)
    }
    
    func lognotificationsVMinVM(didChange state: LoadingState) {
        switch state {
            case .idle:
                refreshControl.endRefreshing()
                MBProgressHUD.hide(for: self.view, animated: true)
            case .overlay:
                MBProgressHUD.showAdded(to: self.view, animated: true)
            default:
                break
        }
    }
}
 
