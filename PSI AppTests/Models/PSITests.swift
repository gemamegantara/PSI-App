//
//  PSITests.swift
//  PSI AppTests
//
//  Created by Gema Megantara on 13/02/18.
//  Copyright © 2018 Gema Megantara. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import PSI_App

class PSITests: XCTestCase {
    
    var psiModelTest: PSI!
    
    override func setUp() {
        super.setUp()
        
        let testJSON: JSON = ["region_metadata": NSArray(),
                                        "items": NSArray()]
        
        self.psiModelTest = PSI(json: testJSON)
    }
    
    override func tearDown() {
        self.psiModelTest = nil
        super.tearDown()
    }
    
    func testModelIsNotNil() {
        XCTAssertNotNil(self.psiModelTest)
        XCTAssertNotNil(self.psiModelTest.regionMetadata)
        XCTAssertNotNil(self.psiModelTest.items)
    }
    
}
