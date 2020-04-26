//
//  Constants.swift
//  SOSVietnam
//
//  Created by Ecko Huynh on 24/04/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import Alamofire
struct K {
    struct ProductionServer {
        static let baseURL = "http://35.224.45.143/api"
    }
    
    struct APIParameterKey {
        static let password = "password"
        static let email = "email"
//        static let email = "email"
//        static let email = "email"
//        static let email = "email"
//        static let email = "email"
//        static let email = "email"
//        static let email = "email"
//        static let email = "email"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
