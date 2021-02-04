//
//  ViewControllerTests.swift
//  BeanioTests
//
//  Created by Murray Goodwin on 04/02/2021.
//

import XCTest
import CoreLocation
@testable import Beanio

class ViewControllerTests: XCTestCase {
  
  var sut: ViewController!

    override func setUpWithError() throws {
        sut = ViewController()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testSettingViewModelLocation() throws {
      sut.viewModel.userLocation = CLLocation(latitude: 51.5154856, longitude: -0.1418396)
    }
  
  func testSettingViewModelCoffeeShops() throws {
    let testLocation = CLLocation(latitude: 51.5154856, longitude: -0.1418396)
    
    sut.viewModel.coffeeShops = [
    CoffeeShop(name: "Murray's Coffee Shack", location: testLocation, distance: 100)
    ]
  }
  
  func testSettingViewModelWarningText() throws {
    sut.viewModel.warningText = "Danger, sharks."
  }

}
