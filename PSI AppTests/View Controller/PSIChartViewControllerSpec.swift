//
//  PSIChartViewControllerSpec.swift
//  PSI AppTests
//
//  Created by Gema Megantara on 13/02/18.
//  Copyright © 2018 Gema Megantara. All rights reserved.
//

import Quick
import Nimble
@testable import PSI_App


class PSIChartViewControllerSpec: QuickSpec {
    override func spec() {
        var viewController: PSIChartViewController!
        
        beforeEach {
            viewController = UIStoryboard(name: "Main", bundle:
                nil).instantiateViewController(withIdentifier:
                    "PSIChartViewController") as! PSIChartViewController
            _ = viewController.view
        }
        
        context("when the view loaded") {
            it("should have title label showing today date") {
                let formatter = DateFormatter()
                formatter.timeZone = TimeZone(abbreviation: "SGT")!
                formatter.dateFormat = "MMM d, yyyy"
                let now = formatter.string(from: Date())
                
                expect(viewController.labelTitle.text).to(equal("24 Hour PSI on \(now)"))
            }
        }
    }
}
