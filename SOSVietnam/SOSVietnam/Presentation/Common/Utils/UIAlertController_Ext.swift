//
//  UIAlertController_Ext.swift
//  SOSVietnam
//
//  Created by Ecko Huynh on 25/04/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit
import RxOptional

extension UIAlertController {
    final class func alertController(forError error: Error, actions: [UIAlertAction]? = nil) -> UIAlertController {
        let errorDescription = { () -> String in
            if let describableError = error as? DescribableError
                , describableError.description.isNotEmpty {
                return describableError.description
            }
            if (error as NSError).localizedDescription.isNotEmpty {
                return (error as NSError).localizedDescription
            }
            return "Something went wrong :/"
        }()
        
        let errorString = "Lỗi"
        return alertController(forTitle: errorString, message: errorDescription, preferredStyle: .alert, actions: actions)
    }
    
    final class func alertController(forTitle title: String, message: String, preferredStyle: UIAlertController.Style = .alert, actions: [UIAlertAction]? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        let actionsToAdd: [UIAlertAction] = {
            guard let actions = actions else {
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                return [okAction]
            }
            return actions
        }()
        
        for action in actionsToAdd {
            alertController.addAction(action)
        }
        
        return alertController
    }
}
protocol DescribableError:
    Error
    , CustomDebugStringConvertible
, CustomStringConvertible {
    var title: String { get }
    var id: String { get }
}
