//
//  JSONParserTests.swift
//  BeanioTests
//
//  Created by Murray Goodwin on 03/02/2021.
//

import XCTest
@testable import Beanio

final class JSONParserTests: XCTestCase {
  
  var sut: JSONParser!
  
  override func setUpWithError() throws {
    sut = JSONParser()
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func testParseCoffeeShopJSONWithNormalResults() throws {
    
    do {
      let testJSON = try Data(contentsOf: Bundle.main.url(forResource: "sampleJSON", withExtension: "json")!)
      XCTAssert(try sut.parseCoffeeShopJSON(testJSON).coffeeShops!.count == 30)
      XCTAssertNil(try sut.parseCoffeeShopJSON(testJSON).warningText)
    } catch {
      XCTFail()
    }
  }
  
  func testParseCoffeeShopJSONWithWarning() throws {
    
    do {
      let testJSON = try Data(contentsOf: Bundle.main.url(forResource: "sampleJSONwithWarningMessage", withExtension: "json")!)
      XCTAssert(try sut.parseCoffeeShopJSON(testJSON).coffeeShops!.count == 0)
      XCTAssertNotNil(try sut.parseCoffeeShopJSON(testJSON).warningText)
      XCTAssert(try sut.parseCoffeeShopJSON(testJSON).warningText == "There aren't a lot of results near you. Try something more general, reset your filters, or expand the search area.")
    } catch {
      XCTFail()
    }
  }
}
