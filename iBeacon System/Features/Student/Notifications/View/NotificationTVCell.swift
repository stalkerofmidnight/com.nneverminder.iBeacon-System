//
//  NotificationTVCell.swift
//  iBeacon System
//
//  Created by Anastasiya Ussenko on 3/29/20.
//  Copyright © 2020 Anastasiya Ussenko. All rights reserved.
//

import UIKit

class NotificationTVCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
