//
//  PSI.swift
//  PSI App
//
//  Created by Gema Megantara on 11/02/18.
//  Copyright © 2018 Gema Megantara. All rights reserved.
//

import Foundation
import SwiftyJSON

struct PSI {
    let regionMetadata: [JSON]
    let items: [JSON]
}

/// Mark: - extension Friend
/// Put init functions inside extension so default constructor
/// for the struct is created
extension PSI {
    init?(json: JSON) {
        guard let regionMetadata = json["region_metadata"].array,
            let items = json["items"].array else {
                return nil
        }
        self.regionMetadata = regionMetadata
        self.items = items
    }
}
