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
        let home = HomeTabbarViewController(nibName: "HomeTabbarViewController", bundle: nil)
        self.pushViewController(home, animated: true)
        
//        let seconds = 0.0
//                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
//        let vc = AnalysisViewController(nibName: "AnalysisViewController", bundle: nil)
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true, completion: nil)
//        self.present(vc, animated: true) {
            
//        }
//        self.window
//        let home = HomeTabbarViewController(nibName: "HomeTabbarViewController", bundle: nil)
//        self.pushViewController(home, animated: true)
//        let seconds = 2.0
//        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
//            let home = HomeTabbarViewController(nibName: "HomeTabbarViewController", bundle: nil)
//             self.pushViewController(home, animated: true)
//            self.navigationItem.setHidesBackButton(true, animated: true)
            
//            let vc = UIViewController()
//            home.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
//            self.present(home, animated: true, completion: nil)
//            self.popViewController(animated: true)
//        }
    }
}
