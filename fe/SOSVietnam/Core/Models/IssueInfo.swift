//
//  IssueInfo.swift
//  SOSVietnam
//
//  Created by Ecko Huynh on 24/04/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
struct IssueInfo: Codable {
    let id: Int?
    let issueName: String?
    let issueType: String?
    let issueDescription: String?
    let fullName: String?
    let address: String?
    let birthday: String?
    let phone: String?
    let email: String?
    let identifyId: String?
    let sex: String?
//    let image: URL?
//    let author : String
    let createDate: String?
    let closeDate: String?
    let isWellBeing: Bool?
    let isDisability: Bool?
    let isHomeless: Bool?
    let urgencyEvaluate: Int?
    
    private enum CodingKeys : String, CodingKey {
        case id, issueName, address, birthday, phone, email, sex
        case fullName = "full_name"
        case identifyId = "identity_number"
        case issueType = "issue_type"
        case issueDescription = "issue_description"
        case isWellBeing = "well_being"
        case isDisability = "disability"
        case isHomeless = "homeless"
        case createDate, closeDate, urgencyEvaluate
    }
}

struct User: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let image: URL
    
    private enum CodingKeys : String, CodingKey {
        case firstName, lastName, email, image
    }
}

struct Article : Codable{
    let id: Int
    let title: String
    let image: URL
    let author : String
    let categories: [Category]
    let datePublished: Date
    let body: String?
    let publisher: String?
    let url: URL?
}
struct Category: Codable {
    let id: Int
    let name: String
    let parentID: Int?
}

extension Category {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case parentID = "parent_id"
    }
}

extension DateFormatter {
    static var articleDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
}
struct IssueResponse: Codable {
    let id: Int
    let homeless: Bool
}
struct IssueType: Codable {
//    case clothes = ""
//    case
    let key: String
    let name: String
}
