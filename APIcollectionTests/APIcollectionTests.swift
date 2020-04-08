//
//  APIcollectionTests.swift
//  APIcollectionTests
//
//  Created by Field Employee on 4/7/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import APIcollection

class APIcollectionTests: XCTestCase {
  var myModelViewTest = ModelView()
  
  func testImageCallEqual() {
    let UIImageFromFunc = myModelViewTest.getAPIImage(urlString: "https://via.placeholder.com/600/92c952")
    let actualImage = UIImage(named: "testpull.png")
    XCTAssert(actualImage!.pngData() == UIImageFromFunc.pngData())
  }
  
  func testImageCallNEqual() {
    let UIImageFromFunc = myModelViewTest.getAPIImage(urlString: "https://via.placeholder.com/600/24f355")
    let actualImage = UIImage(named: "testpull.png")
    XCTAssertFalse(actualImage!.pngData() == UIImageFromFunc.pngData())
  }
  
  func testAPICallEqual() {
    let json: JSON
  }
  
  func testAPICallNEqual() {
    
  }
  
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
