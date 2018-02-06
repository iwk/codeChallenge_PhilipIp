//
//  thredChallenge_PhilipIpTests.swift
//  thredChallenge_PhilipIpTests
//
//  Created by Philip Ip on 5/2/18.
//  Copyright © 2018 Philip. All rights reserved.
//

import XCTest
@testable import thredChallenge_PhilipIp

class thredChallenge_PhilipIpTests: XCTestCase {
    
    var jsonData:Data?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        jsonData = """
        [
        {
        "name":"Sydney",
        "radius":45000,
        "maxRadius":50000,
        "thumbnailUrl":"https://thred-prd-blob-public.s3.amazonaws.com/images/logo_Sydney.png",
        "coord":[
         {
            "latitude":-33.754745,
            "longitude":150.952663
         }
        ]
        },
        {
        "name":"Melbourne ",
        "radius":50000,
        "maxRadius":100000,
        "thumbnailUrl":"https://thred-prd-blob-public.s3.amazonaws.com/images/logo_Melbourne.png",
        "coord":[
         {
            "latitude":-37.826057,
            "longitude":144.959106
         }
        ]
        }
        ]
        """.data(using: .utf8)!
        
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testLoadData() {
        
        let expectation = XCTestExpectation(description: "load json file")
        
        DataManager.sharedInstance.loadJson(urlString: DataAPI.urlString) { (jsonData, err) in
            
            XCTAssertNotNil(jsonData)
            XCTAssertNil(err)
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testLoadDataWithInvalidUrl() {
        
        let expectation = XCTestExpectation(description: "load json file with invalid url")
        
        DataManager.sharedInstance.loadJson(urlString: "http://invalid url") { (jsonData, err) in

            XCTAssertNil(jsonData)
            XCTAssertNotNil(err)
            
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
