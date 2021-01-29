//
//  ViewModel.swift
//  Beanio
//
//  Created by Murray Goodwin on 29/01/2021.
//

import Foundation
import CoreLocation
import UIKit

protocol ViewModelDelegate: AnyObject {
  func viewModel(_ manager: ViewModel, didUpdateUserLocation: CLLocation)
  func viewModel(_ manager: ViewModel, didUpdateCoffeeShops: [CoffeeShop])
}

class ViewModel: NSObject {
  
  private let coreLocationManager = CLLocationManager()
  weak var delegate: ViewModelDelegate?
  private let errorHandler = ErrorHandler()
  var viewController: UIViewController?
    
  var userLocation: CLLocation = CLLocation(latitude: 50.0, longitude: -1.0) {
    didSet {
      delegate?.viewModel(self, didUpdateUserLocation: userLocation)
      print("The User Location was updated in the ViewModel")
    }
  }
  
  var coffeeShops: [CoffeeShop] = [] {
    didSet {
      delegate?.viewModel(self, didUpdateCoffeeShops: coffeeShops)
      print("The Coffee Shop Data was updated in the ViewModel")
    }
  }
  
  func refreshData() {

    coreLocationManager.delegate = self
    
    let userLocationManager = UserLocationManager(coreLocationManager: coreLocationManager)
    
    do {
      try userLocationManager.getCurrentLocation()
      
    } catch ErrorHandler.ErrorType.locationServicesDisabled {
      errorHandler.handleError(errorType: .locationServicesDisabled, viewController: viewController!)
      
    } catch ErrorHandler.ErrorType.locationServicesRestricted {
      errorHandler.handleError(errorType: .locationServicesRestricted, viewController: viewController!)
      
    } catch {
      errorHandler.handleError(errorType: .other, viewController: viewController!)
    }
  }
  
}

// MARK: - CoreLocationManager Delegate
extension ViewModel: CLLocationManagerDelegate {
  
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    print(manager.authorizationStatus)
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
    let userLocationManager = UserLocationManager(coreLocationManager: coreLocationManager)
    
    // Prevent multiple delegate calls from the same search:
    if let foundLocation = locations.last, userLocationManager.coreLocationDidFinishRequestingALocation == false {
      userLocationManager.coreLocationDidFinishRequestingALocation = true
      manager.stopUpdatingLocation()
      
      userLocation = CLLocation(latitude: foundLocation.coordinate.latitude, longitude: foundLocation.coordinate.longitude)
    }
  }
  
  //FIXME: In production, I would handle the various types of error that could be returned here (https://developer.apple.com/documentation/corelocation/cllocationmanagerdelegate/1423786-locationmanager).
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    errorHandler.handleError(errorType: .coreLocationError, viewController: viewController!)
  }
}
