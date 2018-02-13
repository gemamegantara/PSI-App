//
//  PSI.swift
//  PSI App
//
//  Created by Gema Megantara on 11/02/18.
//  Copyright © 2018 Gema Megantara. All rights reserved.
//

import Foundation
import SwiftyJSON

class PSI: NSObject {
    var regionMetadata: [JSON]!
    var items: [JSON]!
    
    init(json: JSON) {
        self.regionMetadata = json["region_metadata"].array
        self.items = json["items"].array
    }
}
