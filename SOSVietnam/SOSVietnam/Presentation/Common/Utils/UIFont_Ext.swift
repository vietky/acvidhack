//
//  UIFont_Ext.swift
//  SOSVietnam
//
//  Created by Ecko Huynh on 24/04/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit

struct AppFontName {
    static let regular = "Lato-Regular"
    static let bold = "Lato-Bold"
    static let italic = "Lato-Italic"
}

extension UIFontDescriptor.AttributeName {
    static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
}
extension UIFont {
    
    @objc
    class func newAppSystemFont(ofSize size: CGFloat) -> UIFont {
        // swiftlint:disable:next force_unwrapping
        return UIFont(name: AppFontName.regular, size: size)!
    }
    
    @objc
    class func newAppBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        // swiftlint:disable:next force_unwrapping
        return UIFont(name: AppFontName.bold, size: size)!
    }
    
    @objc
    class func newAppItalicSystemFont(ofSize size: CGFloat) -> UIFont {
        // swiftlint:disable:next force_unwrapping
        return UIFont(name: AppFontName.italic, size: size)!
    }
    
    @objc
    convenience init(myCoder aDecoder: NSCoder) {
        guard
            let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor,
            let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String else {
                self.init(myCoder: aDecoder)
                return
        }
        var fontName = ""
        switch fontAttribute {
        case "CTFontRegularUsage":
            fontName = AppFontName.regular
        case "CTFontEmphasizedUsage", "CTFontBoldUsage":
            fontName = AppFontName.bold
        case "CTFontObliqueUsage":
            fontName = AppFontName.italic
        default:
            fontName = AppFontName.regular
        }
        // swiftlint:disable:next force_unwrapping
        self.init(name: fontName, size: fontDescriptor.pointSize)!
    }
    
    class func overrideInitialize() {
        guard self == UIFont.self else {
            return
        }
        
        if let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:))),
            let newAppSystemFont = class_getClassMethod(self, #selector(newAppSystemFont(ofSize:))) {
            method_exchangeImplementations(systemFontMethod, newAppSystemFont)
        }
        
        if let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:))),
            let newAppBoldSystemFont = class_getClassMethod(self, #selector(newAppBoldSystemFont(ofSize:))) {
            method_exchangeImplementations(boldSystemFontMethod, newAppBoldSystemFont)
        }
        
        if let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:))),
            let newAppItalicSystemFont = class_getClassMethod(self, #selector(newAppItalicSystemFont(ofSize:))) {
            method_exchangeImplementations(italicSystemFontMethod, newAppItalicSystemFont)
        }
        
        if let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))),
            let newInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:))) {
            method_exchangeImplementations(initCoderMethod, newInitCoderMethod)
        }
    }
}
