//
//  ViewController.swift
//  Beanio
//
//  Created by Murray Goodwin on 29/01/2021.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
  
  private let coreLocationManager = CLLocationManager()
  private let errorHandler = ErrorHandler()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    coreLocationManager.delegate = self
  }
  
  // MARK: - Navigation Bar Items
  @IBAction func getLocationButtonPressed(_ sender: UIBarButtonItem) {
    
    let userLocationManager = UserLocationManager(coreLocationManager: coreLocationManager)
    
    do {
      try userLocationManager.getCurrentLocation()
      
    } catch ErrorHandler.ErrorType.locationServicesDisabled {
      errorHandler.handleError(errorType: .locationServicesDisabled, viewController: self)
      
    } catch ErrorHandler.ErrorType.locationServicesRestricted {
      errorHandler.handleError(errorType: .locationServicesRestricted, viewController: self)
      
    } catch {
      errorHandler.handleError(errorType: .other, viewController: self)
    }
  }
}

// MARK: - CoreLocationManager Delegate
extension ViewController: CLLocationManagerDelegate {
  
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    print(manager.authorizationStatus)
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
    let userLocationManager = UserLocationManager(coreLocationManager: coreLocationManager)
    
    // Prevent multiple delegate calls from the same search:
    if let foundLocation = locations.last, userLocationManager.coreLocationDidFinishRequestingALocation == false {
      userLocationManager.coreLocationDidFinishRequestingALocation = true
      manager.stopUpdatingLocation()
      
      let locationToBeSaved = CLLocation(latitude: foundLocation.coordinate.latitude, longitude: foundLocation.coordinate.longitude)
      print(locationToBeSaved.debugDescription)
    }
  }
  
  //FIXME: In production, I would handle the various types of error that could be returned here (https://developer.apple.com/documentation/corelocation/cllocationmanagerdelegate/1423786-locationmanager).
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    errorHandler.handleError(errorType: .coreLocationError, viewController: self)
  }
}
