//
//  RootViewController.swift
//  SOSVietnam
//
//  Created by Ecko Huynh on 25/04/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class RootViewController: UINavigationController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setHomeAsRoot()
    }
    
    func setHomeAsRoot() {
        let vc = HomeTabbarViewController(nibName: "HomeTabbarViewController", bundle: nil)
        self.pushViewController(vc, animated: true)
    }
}
