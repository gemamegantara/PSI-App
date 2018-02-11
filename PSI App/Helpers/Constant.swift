//
//  Constant.swift
//  PSI App
//
//  Created by Gema Megantara on 11/02/18.
//  Copyright © 2018 Gema Megantara. All rights reserved.
//

import Foundation
import Alamofire

struct Constants {
    static let BASE_URL = "https://api.data.gov.sg/v1/"
    static let PSI_DEV_KEY = "0rjazBufPGUAd2gAK24KOFmQToETrR8m"
    static let GOOGLE_MAP_KEY = "AIzaSyB71PkBVzMRIpwx6iQPnP8_6MF40FKv75Y"
}

class Helper: NSObject {
    static let sharedInstance = Helper()
    private override init() {}
    
    func getHeaders() -> HTTPHeaders{
        
        let headers: HTTPHeaders = [
            "api-key": Constants.PSI_DEV_KEY
        ]
        
        return headers
    }
}
