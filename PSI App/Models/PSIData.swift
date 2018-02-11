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
    var o3SubIndex: Double!
    var pm10TwentyFourHourly: Double!
    var pm10SubIndex: Double!
    var coSubIndex: Double!
    var pm25TwentyFourHourly: Double!
    var so2_sub_index: Double!
    var coEightHourMax: Double!
    var no2OneHourMax: Double!
    var so2TwentyFourHourly: Double!
    var pm25SubIndex: Double!
    var psiTwentyFourHourly: Double!
    var o3EightHourMax: Double!
    
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
}
