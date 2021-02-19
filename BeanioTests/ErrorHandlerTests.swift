//
//  ErrorHandlerTests.swift
//  BeanioTests
//
//  Created by Murray Goodwin on 04/02/2021.
//

import XCTest
@testable import Beanio

class ErrorHandlerTests: XCTestCase {
  
  var sut: ErrorHandler!
  let viewController = UIViewController()
  
  override func setUpWithError() throws {
    sut = ErrorHandler()
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func testPresentErrorWithNoViewController() throws {
    sut.presentError(errorType: .other, viewController: nil)
  }
  
  func testPresentErrors() throws {

    
    for errorType in ErrorHandler.ErrorType.allCases {
      sut.presentError(errorType: errorType, viewController: viewController)
    }
  }
}
