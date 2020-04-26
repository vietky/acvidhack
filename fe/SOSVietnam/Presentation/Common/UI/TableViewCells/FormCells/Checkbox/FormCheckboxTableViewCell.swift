//
//  FormCheckboxTableViewCell.swift
//  SOSVietnam
//
//  Created by Ecko Huynh on 24/04/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class FormCheckboxTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var selectButton: UIButton!
    
    var data: FormContent?
    
    var callback: ((_ value: FormContent)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        iconImageView.layer.cornerRadius = iconImageView.frame.height/2
        iconImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func renderData(content: FormContent) {
        self.data = content
        titleLabel.text = content.name
        if content.isSelected {
            iconImageView.image = UIImage(named: "tick")
            iconImageView.backgroundColor = .white
        } else {
            iconImageView.image = UIImage(named: "whiteTick")
            iconImageView.backgroundColor = .lightGray
        }
    }
    
    @IBAction func cellClick(_ sender: Any) {
        var newData = data
        newData?.isSelected = !(data?.isSelected ?? true)
        if let newData = newData {
            callback?(newData)
        }
    }
}
