//
//  PSIMapViewModelTests.swift
//  PSI AppTests
//
//  Created by Gema Megantara on 13/02/18.
//  Copyright © 2018 Gema Megantara. All rights reserved.
//

import XCTest
@testable import PSI_App

class PSIMapViewModelTests: XCTestCase {
    
    var psiMapViewModelTest: PSIMapViewModel!
    
    override func setUp() {
        super.setUp()
        
        self.psiMapViewModelTest = PSIMapViewModel()
    }
    
    func testInitData(){
        
        let expect = XCTestExpectation(description: "callback")
        
        self.psiMapViewModelTest.showAlertClosure = { [weak self] () in
            XCTFail((self?.psiMapViewModelTest.alertMessage)!)
        }
       
        self.psiMapViewModelTest.setDataOnMapClosure = { [weak self] () in
            expect.fulfill()
            
            let marker = self?.psiMapViewModelTest.getPSIDataObject(loc: "west")
            XCTAssertNotNil(marker)
            
            let infoWindow = self?.psiMapViewModelTest.getPSIInfoWindow(marker: marker!)
            XCTAssertNotNil(infoWindow)
        }
        
        self.psiMapViewModelTest.initData()
        
        wait(for: [expect], timeout: 30.0)
    }
    
    func testGetLoc(){
        let arrLoc = self.psiMapViewModelTest.getPSIDataPosition()
        let compareArr = [String]()
        
        XCTAssertEqual(arrLoc, compareArr, "Success");
    }
    
    func testRefresh(){
        let expect = XCTestExpectation(description: "callback")
        
        self.psiMapViewModelTest.showAlertClosure = { [weak self] () in
            XCTFail((self?.psiMapViewModelTest.alertMessage)!)
        }
        
        self.psiMapViewModelTest.setDataOnMapClosure = { () in
            expect.fulfill()
        }
        
        self.psiMapViewModelTest.refreshData()
        
        wait(for: [expect], timeout: 30.0)
    }
    
    override func tearDown() {
        self.psiMapViewModelTest = nil
        super.tearDown()
    }
}
