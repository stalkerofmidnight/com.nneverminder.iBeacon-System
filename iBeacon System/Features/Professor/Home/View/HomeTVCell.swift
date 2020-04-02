//
//  HomeTVCell.swift
//  iBeacon System
//
//  Created by Anastasiya Ussenko on 3/29/20.
//  Copyright © 2020 Anastasiya Ussenko. All rights reserved.
//

import UIKit

class HomeTVCell: UITableViewCell {

    @IBOutlet weak var studentNameLabel: UILabel!
    @IBOutlet weak var studentEmailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
