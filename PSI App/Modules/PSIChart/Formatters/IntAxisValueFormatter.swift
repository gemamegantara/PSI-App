//
//  IntAxisValueFormatter.swift
//  PSI App
//
//  Created by Gema Megantara on 12/02/18.
//  Copyright © 2018 Gema Megantara. All rights reserved.
//

import Foundation
import Charts

public class IntAxisValueFormatter: NSObject, IAxisValueFormatter {
    private var arrValue: [String]
    
    public init(value: [String]) {
        self.arrValue = value
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return self.arrValue[Int(value)]
    }
}
