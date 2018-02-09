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
    var o3SubIndex: Double
    var pm10TwentyFourHourly: Double
    var pm10SubIndex: Double
    var coSubIndex: Double
    var pm25TwentyFourHourly: Double
    var so2_sub_index: Double
    var coEightHourMax: Double
    var no2OneHourMax: Double
    var so2TwentyFourHourly: Double
    var pm25SubIndex: Double
    var psiTwentyFourHourly: Double
    var o3EightHourMax: Double
 
    init(name: String, latitude: Double, longitude: Double, o3SubIndex: Double, pm10TwentyFourHourly: Double, pm10SubIndex: Double, coSubIndex: Double, pm25TwentyFourHourly: Double, so2_sub_index: Double, coEightHourMax: Double, no2OneHourMax: Double, so2TwentyFourHourly: Double, pm25SubIndex: Double, psiTwentyFourHourly: Double, o3EightHourMax: Double) {
        
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.o3SubIndex = o3SubIndex
        self.pm10TwentyFourHourly = pm10TwentyFourHourly
        self.pm10SubIndex = pm10SubIndex
        self.coSubIndex = coSubIndex
        self.pm25TwentyFourHourly = pm25TwentyFourHourly
        self.so2_sub_index = so2_sub_index
        self.coEightHourMax = coEightHourMax
        self.no2OneHourMax = no2OneHourMax
        self.so2TwentyFourHourly = so2TwentyFourHourly
        self.pm25SubIndex = pm25SubIndex
        self.psiTwentyFourHourly = psiTwentyFourHourly
        self.o3EightHourMax = o3EightHourMax
    }
}
