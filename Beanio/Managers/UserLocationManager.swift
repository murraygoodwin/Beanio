//
//  LocationManager.swift
//  Beanio
//
//  Created by Murray Goodwin on 29/01/2021.
//

import Foundation
import CoreLocation

final class UserLocationManager {
    
  private let coreLocationManager: CLLocationManager
  
  init(coreLocationManager: CLLocationManager) {
    self.coreLocationManager = coreLocationManager
    self.coreLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
  }
  
  // Prevent repeated delegate calls for multiple simultaneous location updates.
  var coreLocationDidFinishRequestingALocation = false
  
  // MARK: - Get current location
  func getCurrentLocation() throws {
    
    guard CLLocationManager.locationServicesEnabled() else { throw ErrorHandler.ErrorType.locationServicesDisabled }
    
    switch coreLocationManager.authorizationStatus {
    
    case .denied: throw ErrorHandler.ErrorType.locationServicesDisabled
      
    case .restricted: throw ErrorHandler.ErrorType.locationServicesRestricted
      
    case .notDetermined: coreLocationManager.requestWhenInUseAuthorization()
      
    case .authorizedAlways, .authorizedWhenInUse:
      coreLocationDidFinishRequestingALocation = false
      coreLocationManager.requestLocation()
      
    @unknown default:
      break
    }
  }
}
