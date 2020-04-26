//
//  UrgencyTableViewCell.swift
//  SOSVietnam
//
//  Created by Ecko Huynh on 25/04/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class UrgencyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var firstIcon: UIImageView!
    @IBOutlet weak var secondIcon: UIImageView!
    @IBOutlet weak var thirdIcon: UIImageView!
    @IBOutlet weak var fourthIcon: UIImageView!
    @IBOutlet weak var fifthIcon: UIImageView!
    
        
    var data: FormContent?
    
    var callback: ((_ value: FormContent)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func renderData(content: FormContent) {
        self.data = content
        if let number = content.contentInput as? Int {
            switch number {
            case 1:
                setFirstClick()
            case 2:
                setSecondClick()
            case 3:
                setThirdClick()
            case 4:
                setFourthClick()
            case 5:
                setFifthClick()
            default:
                break
            }
        }
    }
    
    @IBAction func firstIconClick(_ sender: Any) {
        setFirstClick()
        data?.contentInput = 1
        if let data = data{
            callback?(data)
        }
    }
    
    @IBAction func secondIconClick(_ sender: Any) {
        setSecondClick()
        data?.contentInput = 2
        if let data = data{
            callback?(data)
        }
    }
    @IBAction func thirdIconClick(_ sender: Any) {
        setThirdClick()
        data?.contentInput = 3
        if let data = data{
            callback?(data)
        }
    }
    @IBAction func fourthIconClick(_ sender: Any) {
        setFourthClick()
        data?.contentInput = 4
        if let data = data{
            callback?(data)
        }
    }
    
    @IBAction func fifthIconClick(_ sender: Any) {
        setFifthClick()
        data?.contentInput = 5
        if let data = data{
            callback?(data)
        }
    }
    func setFirstClick() {
        firstIcon.image = UIImage(named: "exclamation")
        secondIcon.image = UIImage(named: "greyCircle")
        thirdIcon.image = UIImage(named: "greyCircle")
        fourthIcon.image = UIImage(named: "greyCircle")
        fifthIcon.image = UIImage(named: "greyCircle")
    }
    func setSecondClick() {
        firstIcon.image = UIImage(named: "exclamation")
        secondIcon.image = UIImage(named: "exclamation")
        thirdIcon.image = UIImage(named: "greyCircle")
        fourthIcon.image = UIImage(named: "greyCircle")
        fifthIcon.image = UIImage(named: "greyCircle")
    }
    func setThirdClick() {
        firstIcon.image = UIImage(named: "exclamation")
        secondIcon.image = UIImage(named: "exclamation")
        thirdIcon.image = UIImage(named: "exclamation")
        fourthIcon.image = UIImage(named: "greyCircle")
        fifthIcon.image = UIImage(named: "greyCircle")
    }
    func setFourthClick() {
        firstIcon.image = UIImage(named: "exclamation")
        secondIcon.image = UIImage(named: "exclamation")
        thirdIcon.image = UIImage(named: "exclamation")
        fourthIcon.image = UIImage(named: "exclamation")
        fifthIcon.image = UIImage(named: "greyCircle")
    }
    func setFifthClick() {
        firstIcon.image = UIImage(named: "exclamation")
        secondIcon.image = UIImage(named: "exclamation")
        thirdIcon.image = UIImage(named: "exclamation")
        fourthIcon.image = UIImage(named: "exclamation")
        fifthIcon.image = UIImage(named: "exclamation")
    }
}
