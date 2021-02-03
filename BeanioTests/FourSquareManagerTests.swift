//
//  BeanioTests.swift
//  BeanioTests
//
//  Created by Murray Goodwin on 29/01/2021.
//

import XCTest
import CoreLocation
@testable import Beanio

class FourSquareManagerTests: XCTestCase {
  
  var sut: FourSquareManager!
  
  override func setUpWithError() throws {
    sut = FourSquareManager()
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func testConstructingAPI() throws {
    
    let baseURL = "https://api.foursquare.com/v2/venues/explore"
    let parameters = [
      "client_id" : "44XM5RRWRON31R41GVKJTE2KA0GNTOI50HYUAFI2E5C0IQN5", // Random client ID for testing.
      "client_secret" : "3EHLQEFMBISD4HGZM1FIB1XQIDGQMI2J1QX4T5SZ12QQGAS3", // Random client secret for testing.
      "v" : "20210131", // 'Version' - an arbitrary date to be updated periodically when the app is updated.
      "section" : "coffee",
      "ll" : "51.5154856,-0.1418396"]

    let generatedURL = sut.assembleURL(baseURL: baseURL, parameters: parameters)
    XCTAssertTrue(UIApplication.shared.canOpenURL(generatedURL!))
  }
  
  func testDownloadVenueDataNearLocation() {
    
    let testLocation = CLLocation(latitude: 51.5154856, longitude: -0.1418396)
  
    sut.downloadVenueDataNearLocation(location: testLocation) { (data) in
      // FIXME: I have been trying (and failing!) to find a way to test for nil data values being retured (e.g. in case of loss of a search with no connectivity), but it always seems to pass. Any feedback welcome!
      XCTAssert(data?.isEmpty == false)
    }
  }
}
