//
//  JSONParser.swift
//  Beanio
//
//  Created by Murray Goodwin on 01/02/2021.
//

import Foundation
import CoreLocation

struct JSONParser {
  
  func parseJSON(data: Data) {
    
  }
  
  // TODO: Maybe make this throwing?
  func parseCoffeeShopJSON(_ data: Data) -> CoffeeShop? {
    do {
    let coffeeShopData = try JSONDecoder().decode(CoffeeShopData.self, from: data)
      
      //TODO: Handle this better.
      guard coffeeShopData.meta.code == 200 else {
        fatalError("Error with the JSON.")
      }
      
      let name = coffeeShopData.response.groups[0].items[0].venue.name
      let latitude = coffeeShopData.response.groups[0].items[0].venue.location.lat
      let longitude = coffeeShopData.response.groups[0].items[0].venue.location.lng
      let distance = coffeeShopData.response.groups[0].items[0].venue.location.distance
      
      let coffeeShop = CoffeeShop(name: name,
                                  location: CLLocation(latitude: latitude, longitude: longitude),
                                  distance: distance)
      
      // Currently returns a single one
      return coffeeShop
      
      
      
      
    } catch {
      fatalError("Error decoding JSON.")
    }
      
      
   
//    guard coffeeShopData.results.count > 0 else {
//      didFailWithError(reason: .zeroCoffeeShopsReturnedFromSearch)
//      return nil
//    }

    
//    return coffeeShopData.response.map { CoffeeShop(response: $0) }
  }
  
}
