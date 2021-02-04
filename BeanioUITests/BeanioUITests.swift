//
//  BeanioUITests.swift
//  BeanioUITests
//
//  Created by Murray Goodwin on 29/01/2021.
//

import XCTest
@testable import Beanio

final class BeanioUITests: XCTestCase {
  
  let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
      app.terminate()
    }

  // Assumes location permissions have already been granted.
  // Assumes user location is in an area with coffee shops to return.
    func testSearchingFromRegularLaunch() throws {
        let app = XCUIApplication()
        app.launch()
      
      let searchButton = app.buttons["searchNearbyWelcomeButton"]
      XCTAssertTrue(searchButton.exists)
      searchButton.tap()
      
      //TODO: I would like to include a test to show the activity indicator / loading pop-up but it disappears too quickly for me to be able to test it.
      
      let tableView = app.tables["coffeeVenuesTableView"]
      XCTAssertTrue(tableView.exists)
      
    }
  
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
