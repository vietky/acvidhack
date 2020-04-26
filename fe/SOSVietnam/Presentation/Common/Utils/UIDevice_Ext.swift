//
//  UIDevice_Ext.swift
//  SOSVietnam
//
//  Created by Ecko Huynh on 25/04/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit
extension UIDevice {
    public class var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    public class var isPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
}
