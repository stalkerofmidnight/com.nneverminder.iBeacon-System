//
//  NotificationsEmptyView.swift
//  iBeacon System
//
//  Created by Anastasiya Ussenko on 3/28/20.
//  Copyright © 2020 Anastasiya Ussenko. All rights reserved.
//

import UIKit

final class NotificationsEmptyView: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
    }
    
    convenience init(name: String) {
        self.init(frame: .zero)
        titleLabel.text = "Welcome, \(name)\nYou don’t have any notifications yet"
    }
    
    private func initialSetup() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}
