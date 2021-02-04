//
//  ViewModelTests.swift
//  BeanioTests
//
//  Created by Murray Goodwin on 04/02/2021.
//

import XCTest
import CoreLocation
@testable import Beanio

class ViewModelTests: XCTestCase {
  
  var sut: ViewModel!

    override func setUpWithError() throws {
        sut = ViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testRefreshingDataWithLocationServicesEnabled() throws {
      sut.refreshData()
    }

}
