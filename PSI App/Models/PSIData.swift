//
//  PSIData.swift
//  PSI App
//
//  Created by Gema Megantara on 10/02/18.
//  Copyright © 2018 Gema Megantara. All rights reserved.
//

import Foundation

class PSIData: NSObject {
    var name: String
    var latitude: Double
    var longitude: Double
    var reading = [PSIReading]()
    
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
}
