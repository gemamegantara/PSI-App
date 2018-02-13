//
//  PSIReadingTests.swift
//  PSI AppTests
//
//  Created by Gema Megantara on 13/02/18.
//  Copyright © 2018 Gema Megantara. All rights reserved.
//

import XCTest
@testable import PSI_App

class PSIReadingTests: XCTestCase {
    
    var PSIReadingModelTest: PSIReading!
    
    override func setUp() {
        super.setUp()
        self.PSIReadingModelTest = PSIReading()
    }
    
    override func tearDown() {
        self.PSIReadingModelTest = nil
        super.tearDown()
    }
    
    func testClassAttribute(){
        XCTAssertNil(self.PSIReadingModelTest.o3SubIndex)
        XCTAssertNil(self.PSIReadingModelTest.pm10TwentyFourHourly)
        XCTAssertNil(self.PSIReadingModelTest.pm10SubIndex)
        XCTAssertNil(self.PSIReadingModelTest.coSubIndex)
        XCTAssertNil(self.PSIReadingModelTest.pm25TwentyFourHourly)
        XCTAssertNil(self.PSIReadingModelTest.so2_sub_index)
        XCTAssertNil(self.PSIReadingModelTest.coEightHourMax)
        XCTAssertNil(self.PSIReadingModelTest.no2OneHourMax)
        XCTAssertNil(self.PSIReadingModelTest.so2TwentyFourHourly)
        XCTAssertNil(self.PSIReadingModelTest.pm25SubIndex)
        XCTAssertNil(self.PSIReadingModelTest.psiTwentyFourHourly)
        XCTAssertNil(self.PSIReadingModelTest.o3EightHourMax)
        XCTAssertNil(self.PSIReadingModelTest.timestamp)
    }
}
