//
//  HotlineTableViewCell.swift
//  SOSVietnam
//
//  Created by Ecko Huynh on 25/04/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class HotlineTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var addressIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func renderData(hotline: Hotline) {
        nameLabel.text = hotline.title
        phoneLabel.text = hotline.phone
        if hotline.address.isEmpty {
            addressIcon.isHidden = true
        } else {
            addressIcon.isHidden = false
        }
        addressLabel.text = hotline.address
    }
}
