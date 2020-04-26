//
//  HomeTabbarViewController.swift
//  SOSVietnam
//
//  Created by Ecko Huynh on 24/04/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class HomeTabbarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = UIColor(hexFromString: "F40B32")
        
        let listNewsViewController = ListNewsViewController()
        listNewsViewController.tabBarItem = UITabBarItem(title: "Trang chủ", image: UIImage(named: "main")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage: UIImage(named: "mainSelected"))
        
        let listStockMapViewController = ListStockMapViewController()
        listStockMapViewController.tabBarItem = UITabBarItem(title: "Điểm cứu trợ", image: UIImage(named: "home")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage: UIImage(named: "homeSelected"))
        
        let formRequestViewController = FormRequestViewController()
        formRequestViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "add")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage: UIImage(named: "addSelected"))

        
        let listRequestViewController = ListRequestViewController()
        listRequestViewController.tabBarItem = UITabBarItem(title: "Yêu cầu", image: UIImage(named: "notification")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage: UIImage(named: "redNotification"))
        
        let settingViewController = SettingViewController()
        settingViewController.tabBarItem = UITabBarItem(title: "Mở rộng", image: UIImage(named: "more")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage: UIImage(named: "moreSelected"))
        
        // Thu tu tren tabbar
        let tabBarList = [listNewsViewController, listStockMapViewController, formRequestViewController, listRequestViewController, settingViewController]
        
        
        viewControllers = tabBarList
//        sleep(4)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
