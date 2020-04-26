//
//  RequestTableViewCell.swift
//  SOSVietnam
//
//  Created by Ecko Huynh on 24/04/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class RequestTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet weak var pointImageView: UIImageView!
    @IBOutlet weak var pointLabel: UILabel!
    
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var reportButton: UIButton!
    @IBOutlet weak var evaluateLabel: UILabel!
    
    var callback: ((_ value: IssueInfo,_ isAccept: Bool)->())?
    
    var issueInfo: IssueInfo?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.acceptButton.layer.masksToBounds = true
        self.acceptButton.layer.cornerRadius = 8
        self.reportButton.layer.masksToBounds = true
        self.reportButton.layer.cornerRadius = 8
        self.evaluateLabel.layer.masksToBounds = true
        self.evaluateLabel.layer.cornerRadius = 8
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func renderData(issueInfo: IssueInfo) {
        self.issueInfo = issueInfo
        titleLabel.text = issueInfo.issueType
        subtitleLabel.text = issueInfo.issueDescription
        pointLabel.text = "\(issueInfo.urgencyEvaluate)"
//        if issueInfo.urgencyEvaluate == nil {
            pointLabel.isHidden = true
            pointImageView.isHidden = true
//        }
        evaluateLabel.text = " Thấp "
        evaluateLabel.backgroundColor = .lightGray
        if (issueInfo.isDisability ?? false) && (issueInfo.isHomeless ?? false) && !(issueInfo.isWellBeing ?? false) {
            evaluateLabel.text = " Cao "
            evaluateLabel.backgroundColor = .red
        }
        if (issueInfo.isDisability ?? false) && (issueInfo.isHomeless ?? false) && !(issueInfo.isWellBeing ?? false) {
            evaluateLabel.text = " Trung bình "
        }
    }
    
    @IBAction func acceptClick(_ sender: Any) {
        if let issueInfo = issueInfo {
            callback?(issueInfo, true)
        }
    }
    
    @IBAction func reportClick(_ sender: Any) {
        if let issueInfo = issueInfo {
            callback?(issueInfo, false)
        }
    }
    
}
