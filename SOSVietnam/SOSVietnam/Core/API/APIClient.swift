//
//  APIClient.swift
//  SOSVietnam
//
//  Created by Ecko Huynh on 24/04/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Alamofire

class APIClient {
    @discardableResult
    private static func performRequest<T:Decodable>(route:APIRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (AFDataResponse<T>)->Void) -> DataRequest {
        return AF.request(route)
                        .responseDecodable (decoder: decoder){ (response: AFDataResponse) in
                            completion(response.self)
        }
    }
    
    static func login(email: String, password: String, completion:@escaping (AFDataResponse<User>)->Void) {
        performRequest(route: APIRouter.login(email: email, password: password), completion: completion)
    }

    static func getFoodDepots(completion: @escaping (AFDataResponse<[Depot]>)->Void) {
        let jsonDecoder = JSONDecoder()
//                jsonDecoder.dateDecodingStrategy = .formatted(.articleDateFormatter)
        performRequest(route: APIRouter.getFoodDepot, decoder: jsonDecoder, completion: completion)
    }
    
    static func createIssue(issue: IssueInfo, completion:@escaping (AFDataResponse<IssueResponse>)->Void) {
        performRequest(route: APIRouter.issues(info: issue), completion: completion)
    }
    
    static func getAllIssues(completion: @escaping (AFDataResponse<[IssueInfo]>)->Void) {
        let jsonDecoder = JSONDecoder()
        //                jsonDecoder.dateDecodingStrategy = .formatted(.articleDateFormatter)
        performRequest(route: APIRouter.getIssues, decoder: jsonDecoder, completion: completion)
    }
}
