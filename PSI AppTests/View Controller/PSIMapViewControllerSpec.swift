//
//  PSIMapViewControllerSpec.swift
//  PSI AppTests
//
//  Created by Gema Megantara on 13/02/18.
//  Copyright © 2018 Gema Megantara. All rights reserved.
//

import Quick
import Nimble
@testable import PSI_App

class PSIMapViewControllerSpec: QuickSpec {
    override func spec() {
        var viewController: PSIMapViewController!
        
        beforeEach {
            viewController = UIStoryboard(name: "Main", bundle:
                nil).instantiateViewController(withIdentifier:
                    "PSIMapViewController") as! PSIMapViewController
            _ = viewController.view
        }
        
        context("when the view loaded") {
            it("should have initialized the map") {
                expect(viewController.mapView).toNot(beNil())
            }
        }
    }
}
