//
//  UserLocationManagerTests.swift
//  BeanioTests
//
//  Created by Murray Goodwin on 04/02/2021.
//

import XCTest
import CoreLocation
@testable import Beanio

class UserLocationManagerTests: XCTestCase {
  
  var sut: UserLocationManager!
  var coreLocationManager = CLLocationManager()

    override func setUpWithError() throws {
        sut = UserLocationManager(coreLocationManager: coreLocationManager)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

  // TODO: I would like to be able to test this implementation, but I don't have an easy way to handle delegation from  CLLocationManager for testing and spoofing different location permissions. If I had more time available, I would be keen to explore options here.
    func testGetCurrentLocation() throws {
            
    }

}
