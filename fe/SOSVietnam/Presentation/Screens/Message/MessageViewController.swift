//
//  MessageViewController.swift
//  SOSVietnam
//
//  Created by Ecko Huynh on 24/04/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {

    @IBOutlet weak var msgImageView: UIImageView!
    @IBOutlet weak var messageTitle: UILabel!
    
    var text = "Yêu cầu hỗ trợ của bạn đã được ghi nhận. \n Chúng tôi sẽ liên hệ và xác thực trong thời gian sớm nhất"
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTitle.textColor = UIColor.red
        messageTitle.text = text
//        messageTitle.text = "Cám ơn lòng tốt của bạn. Yêu cầu giúp đỡ của bạn đã được ghi nhận. \n Chúng tôi sẽ liên hệ và xác thực trong thời gian sớm nhất."
        
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
