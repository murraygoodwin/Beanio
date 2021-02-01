//
//  CoffeeShop.swift
//  Beanio
//
//  Created by Murray Goodwin on 01/02/2021.
//

import Foundation
import CoreLocation

struct CoffeeShop {
  
  let name: String
  let location: CLLocation
  let distance: Int
  
  init(name: String, location: CLLocation, distance: Int) {
    self.name = name
    self.location = location
    self.distance = distance
  }
}
