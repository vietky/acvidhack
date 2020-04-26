//
//  Depot.swift
//  SOSVietnam
//
//  Created by Ecko Huynh on 24/04/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
struct Depot: Codable {
    let id: String
    let name: String
    let address: String
    let image: URL?
    let longitude: Float
    let latitude: Float
    let datePublished: Date?
    let provider: String?
    let phone: String?
//    let merchandiseList: [Merchandise]?
    let url: URL?
}
struct Merchandise: Codable {
    let id: String
    let name: String
}
