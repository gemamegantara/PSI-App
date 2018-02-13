//
//  PSIChartViewModelTests.swift
//  PSI AppTests
//
//  Created by Gema Megantara on 13/02/18.
//  Copyright © 2018 Gema Megantara. All rights reserved.
//

import XCTest
@testable import PSI_App

class PSIChartViewModelTests: XCTestCase {
    
    var psiChartViewModelTest: PSIChartViewModel!
    
    override func setUp() {
        super.setUp()
        self.psiChartViewModelTest = PSIChartViewModel()
    }
    
    func testInitData(){
        
        let expect = XCTestExpectation(description: "callback")
        
        self.psiChartViewModelTest.showAlertClosure = { [weak self] () in
            XCTFail((self?.psiChartViewModelTest.alertMessage)!)
        }
        
        self.psiChartViewModelTest.setDataOnChartClosure = { [weak self] () in
            expect.fulfill()
            
            let axisData = self?.psiChartViewModelTest.getDataAxisForChart()
            XCTAssertNotNil(axisData)
            
            let data = self?.psiChartViewModelTest.getDataSetsForChart()
            XCTAssertNotNil(data)
            
        }
        self.psiChartViewModelTest.initData()
        
        wait(for: [expect], timeout: 5.0)
    }
    
    func testRefresh(){
        let expect = XCTestExpectation(description: "callback")
        
        self.psiChartViewModelTest.showAlertClosure = { [weak self] () in
            XCTFail((self?.psiChartViewModelTest.alertMessage)!)
        }
        
        self.psiChartViewModelTest.setDataOnChartClosure = { [weak self] () in
            expect.fulfill()
        }
        
        self.psiChartViewModelTest.refreshData()
        
        wait(for: [expect], timeout: 5.0)
    }
    
    override func tearDown() {
        self.psiChartViewModelTest = nil
        super.tearDown()
    }
}
