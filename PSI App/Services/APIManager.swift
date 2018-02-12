//
//  APIManager.swift
//  PSI App
//
//  Created by Gema Megantara on 11/02/18.
//  Copyright © 2018 Gema Megantara. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIManager {
    
    // MARK: - GetFriends
    enum APIFailureReason: Int, Error {
        case unAuthorized = 401
        case notFound = 404
    }
    
    typealias GetPSIResult = Result<PSI, APIFailureReason>
    typealias GetPSICompletion = (_ result: GetPSIResult) -> Void
    
    
    func getPSIData(param: String, value: String, completion: @escaping GetPSICompletion) {
        let parameters: Parameters = [
            param: value,
            ]
        Alamofire.request(Constants.BASE_URL+"environment/psi", method: HTTPMethod.get, parameters: parameters, encoding: URLEncoding.default, headers: Helper.sharedInstance.getHeaders())
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    completion(Result.success(payload: PSI(json: json)!))
                case .failure(_):
                    if let statusCode = response.response?.statusCode,
                        let reason = APIFailureReason(rawValue: statusCode) {
                        completion(.failure(reason))
                    }
                    completion(.failure(nil))
                }
        }
    }
    
   
}

