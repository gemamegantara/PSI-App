//
//  PSIDataTests.swift
//  PSI AppTests
//
//  Created by Gema Megantara on 13/02/18.
//  Copyright © 2018 Gema Megantara. All rights reserved.
//

import XCTest
@testable import PSI_App

class PSIDataTests: XCTestCase {
    
    var psiDataModelTest: PSIData!
    
    override func setUp() {
        super.setUp()
        self.psiDataModelTest = PSIData(name: "west", latitude: 1.021, longitude: 0.1231)
    }
    
    override func tearDown() {
        self.psiDataModelTest = nil
        super.tearDown()
    }
    
    
    func testModelIsNotNil() {
        XCTAssertNotNil(self.psiDataModelTest)
        XCTAssertNotNil(self.psiDataModelTest.name)
        XCTAssertNotNil(self.psiDataModelTest.latitude)
        XCTAssertNotNil(self.psiDataModelTest.longitude)
    }

}
