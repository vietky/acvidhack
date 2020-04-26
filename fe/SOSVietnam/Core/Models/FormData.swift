//
//  FormData.swift
//  SOSVietnam
//
//  Created by Ecko Huynh on 24/04/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
struct FormData {
    var sections: [FormSection]
}
struct FormSection {
    let id: Int
    let title: String
    var contentItems: [FormContent]
}
struct FormContent {
    let id: Int
//    let key: String
    let name: String
    let type: FormContentType
    var isSelected: Bool
    let isRequired: Bool
    var contentInput: Any?
    
    init(id: Int, name: String, type: FormContentType, isRequired: Bool, isSelected: Bool = false, contentInput: Any? = nil) {
        self.id = id
        self.name = name
        self.type = type
        self.isRequired = isRequired
        self.isSelected = isSelected
        self.contentInput = contentInput
    }
}
enum FormContentType {
    case textField
    case checkbox
    case textBox
    case urgency
    case sendForm
    case uploadImage
}
struct FormContentKey {

let key : Int

func getString() -> String {

    switch(key) {
    case 0:
        return "";
    case 1:
        return "Nhập yêu cầu"
    case 3:
        return "Họ & Tên"
    default:
        return "(reserved)"
    }
}
}
