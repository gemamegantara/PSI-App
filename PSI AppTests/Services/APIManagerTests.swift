//
//  APIManagerTests.swift
//  PSI AppTests
//
//  Created by Gema Megantara on 13/02/18.
//  Copyright © 2018 Gema Megantara. All rights reserved.
//

import XCTest
@testable import PSI_App

class APIManagerTests: XCTestCase {
    var api: APIManager?
    
    override func setUp() {
        super.setUp()
        api = APIManager()
    }
    
    override func tearDown() {
        api = nil
        super.tearDown()
    }
    
    func testFetchPSI() {
        
        let expect = XCTestExpectation(description: "callback")
        
        api?.getPSIData(param: "date", value: "2018-02-12", completion: { [weak self] result in
            switch result {
            case .success(let psi):
                expect.fulfill()
                XCTAssertNotNil(psi)
                XCTAssertNotNil(psi.regionMetadata)
                XCTAssertNotNil(psi.items)
            case .failure( _):
                XCTFail()
            }
        })
        
        wait(for: [expect], timeout: 5.0)
    }
}
