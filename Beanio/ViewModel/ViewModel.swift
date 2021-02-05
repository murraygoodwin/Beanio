//
//  ViewModel.swift
//  Beanio
//
//  Created by Murray Goodwin on 29/01/2021.
//

//FIXME: Remove force-unwrapping of viewController in Error Handler...

import Foundation
import CoreLocation
import UIKit

protocol ViewModelDelegate: AnyObject {
  func viewModel(_ manager: ViewModel, didUpdateUserLocation: CLLocation)
  func viewModel(_ manager: ViewModel, didUpdateCoffeeShops: [CoffeeShop])
  func viewModel(_ manager: ViewModel, didUpdateWarningText: String?)
}

final class ViewModel: NSObject {
  
  private let coreLocationManager = CLLocationManager()
  private let errorHandler = ErrorHandler()
  private let fourSquareManager = FourSquareManager()

  weak var delegate: ViewModelDelegate?
  var viewController: UIViewController?
  
  // MARK: - Location + venue properties
  var userLocation: CLLocation = CLLocation(latitude: 51.5154856, longitude: -0.1418396) {
    didSet {
      delegate?.viewModel(self, didUpdateUserLocation: userLocation)
    }
  }
  
  var coffeeShops: [CoffeeShop] = [] {
    didSet {
      delegate?.viewModel(self, didUpdateCoffeeShops: coffeeShops)
    }
  }
  
  var warningText: String? {
    didSet {
      delegate?.viewModel(self, didUpdateWarningText: warningText)
    }
  }
  
  // MARK: - Refresh Data
  func refreshData() {
    
    coreLocationManager.delegate = self
    fourSquareManager.delegate = self
    errorHandler.delegate = viewController as? ErrorHandlerDelegate
    
    let userLocationManager = UserLocationManager(coreLocationManager: coreLocationManager)
    
    do {
      try userLocationManager.getCurrentLocation()
      
    } catch ErrorHandler.ErrorType.locationServicesDisabled {
      errorHandler.presentError(errorType: .locationServicesDisabled, viewController: viewController)
      
    } catch ErrorHandler.ErrorType.locationServicesRestricted {
      errorHandler.presentError(errorType: .locationServicesRestricted, viewController: viewController)
      
    } catch {
      errorHandler.presentError(errorType: .other, viewController: viewController)
    }
  }
}

// MARK: - CoreLocationManager Delegate
extension ViewModel: CLLocationManagerDelegate {
  
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    refreshData()
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
    let userLocationManager = UserLocationManager(coreLocationManager: coreLocationManager)
    
    // Prevent multiple delegate calls from the same search:
    if let foundLocation = locations.last, userLocationManager.coreLocationDidFinishRequestingALocation == false {
      userLocationManager.coreLocationDidFinishRequestingALocation = true
      manager.stopUpdatingLocation()
      userLocation = CLLocation(latitude: foundLocation.coordinate.latitude, longitude: foundLocation.coordinate.longitude)
      
      fourSquareManager.downloadVenueDataNearLocation(location: userLocation) { (data) in
        guard let data = data else { return }
        
        do {
          let jsonParser = JSONParser()
          
          if let parsedShops = try jsonParser.parseCoffeeShopJSON(data).coffeeShops {
            self.coffeeShops = parsedShops.sorted(by: { $0.distance < $1.distance })
          }
          
          self.warningText = try jsonParser.parseCoffeeShopJSON(data).warningText
          
        } catch {
          self.errorHandler.presentError(errorType: .other, viewController: self.viewController)
        }
      }
    }
  }
  
  //FIXME: In production, I would handle the various types of error that could be returned here (https://developer.apple.com/documentation/corelocation/cllocationmanagerdelegate/1423786-locationmanager).
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    errorHandler.presentError(errorType: .coreLocationError, viewController: viewController)
  }
}

// MARK: - FourSquare delegate
extension ViewModel: FourSquareMangerDelegate {
  
  func fourSquareManager(_ manager: FourSquareManager, didFailWithError: ErrorHandler.ErrorType) {
    errorHandler.presentError(errorType: didFailWithError, viewController: viewController)
  }
}
