//
//  JSONParserTests.swift
//  BeanioTests
//
//  Created by Murray Goodwin on 03/02/2021.
//

import XCTest
@testable import Beanio

class JSONParserTests: XCTestCase {
  
  var sut: JSONParser!
  
  override func setUpWithError() throws {
    sut = JSONParser()
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func testParseCoffeeShopJSON() throws {
    
    let testJSON = try Data(contentsOf: Bundle.main.url(forResource: "sampleJSON", withExtension: "json")!)
    XCTAssert(try sut.parseCoffeeShopJSON(testJSON).coffeeShops!.count == 30)
    XCTAssertNil(try sut.parseCoffeeShopJSON(testJSON).warningText)
  }
}
