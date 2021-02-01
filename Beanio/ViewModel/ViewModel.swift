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
  func viewModel(_ manager: ViewModel, didUpdateCoffeeShops: [CoffeeShopData])
}

class ViewModel: NSObject {
  
  private let coreLocationManager = CLLocationManager()
  weak var delegate: ViewModelDelegate?
  private let errorHandler = ErrorHandler()
  var viewController: UIViewController?
  
  // MARK: - Location + venue properties
  var userLocation: CLLocation = CLLocation(latitude: 51.5154856, longitude: -0.1418396) {
    didSet {
      delegate?.viewModel(self, didUpdateUserLocation: userLocation)
      print("The User Location was updated in the ViewModel")
    }
  }
  
  var coffeeShops: [CoffeeShopData] = [] {
    didSet {
      delegate?.viewModel(self, didUpdateCoffeeShops: coffeeShops)
      print("The Coffee Shop Data was updated in the ViewModel")
    }
  }
  
  // MARK: - Refresh Data
  func refreshData() {

    coreLocationManager.delegate = self
    
    let userLocationManager = UserLocationManager(coreLocationManager: coreLocationManager)
    
    do {
      try userLocationManager.getCurrentLocation()
      
    } catch ErrorHandler.ErrorType.locationServicesDisabled {
      errorHandler.presentError(errorType: .locationServicesDisabled, viewController: viewController!)
      
    } catch ErrorHandler.ErrorType.locationServicesRestricted {
      errorHandler.presentError(errorType: .locationServicesRestricted, viewController: viewController!)
      
    } catch {
      errorHandler.presentError(errorType: .other, viewController: viewController!)
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
      
      let fourSquareManager = FourSquareManager()
      
      do {
        try fourSquareManager.downloadVenueDataNearLocation(location: userLocation) { (data) in
          
         // Check the data isn't nil (not really needed since already checked).
          // Then parse the JSON...
          
          guard let data = data else {
            fatalError("No data returned from FourSquare API.")
          }
          
          let jsonParser = JSONParser()
          let coffeeShop = jsonParser.parseCoffeeShopJSON(data)
          print(coffeeShop.debugDescription)

          
          print("Data received...")
        }
        
      } catch ErrorHandler.ErrorType.errorAccessingTheAPI {
        errorHandler.presentError(errorType: .errorAccessingTheAPI, viewController: viewController!)
        
      } catch {
        errorHandler.presentError(errorType: .other, viewController: viewController!)
      }
    }
  }
  
  //FIXME: In production, I would handle the various types of error that could be returned here (https://developer.apple.com/documentation/corelocation/cllocationmanagerdelegate/1423786-locationmanager).
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    errorHandler.presentError(errorType: .coreLocationError, viewController: viewController!)
  }
}
