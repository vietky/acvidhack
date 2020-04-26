//
//  SubjectLabelable.swift
//  SOSVietnam
//
//  Created by Ecko Huynh on 24/04/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

protocol SubjectLabelable {
    static var subjectLabel: String { get }
    var subjectLabel: String { get }
}

extension SubjectLabelable {
    static var subjectLabel: String {
        let result: String = String(describing: self)
        return result
    }

    var subjectLabel: String {
        let result: String = String(describing: type(of: self))
        return result
    }
}

extension NSObject: SubjectLabelable {}
