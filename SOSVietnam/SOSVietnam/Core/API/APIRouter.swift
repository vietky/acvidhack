//
//  APIRouter.swift
//  SOSVietnam
//
//  Created by Ecko Huynh on 24/04/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import Alamofire
enum APIRouter: URLRequestConvertible {
    
    case login(email:String, password:String)
    case posts
    case post(id: Int)
    case getFoodDepot
    case issues(info: IssueInfo)
    case getIssues
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .login, .issues:
            return .post
        case .posts, .post, .getFoodDepot, .getIssues:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .login:
            return "/login"
        case .posts:
            return "/posts"
        case .post(let id):
            return "/posts/\(id)"
        case .getFoodDepot:
            return "/food_depot/get-all"
        case .issues(info: _):
            return "/issues"
        case .getIssues:
            return "/issues/get-all"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .login(let email, let password):
            return [K.APIParameterKey.email: email, K.APIParameterKey.password: password]
        case .posts, .post, .getFoodDepot, .getIssues:
            return nil
        case .issues(info: let issue):
            return ["full_name": issue.fullName ?? "",
                    "address": issue.address ?? "",
                    "birthday": issue.birthday ?? "",
                    "phone": issue.phone ?? "",
                    "email": issue.email ?? "",
                    "identity_number": issue.identifyId ?? "",
                    "sex": issue.sex ?? "",
                    "issue_type": issue.issueType ?? "",
                    "issue_description": issue.issueDescription ?? "",
                    "well_being": issue.isWellBeing ?? false,
                    "disability": issue.isDisability ?? false,
                    "homeless": issue.isHomeless ?? false
            ]
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try K.ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}
