//
//  JSONParser.swift
//  Beanio
//
//  Created by Murray Goodwin on 01/02/2021.
//

import Foundation
import CoreLocation

struct JSONParser {
  
  func parseCoffeeShopJSON(_ data: Data) throws -> (coffeeShops: [CoffeeShop]?, warningText: String?) {
    
    do {
    let coffeeShopData = try JSONDecoder().decode(CoffeeShopData.self, from: data)
      
      guard coffeeShopData.meta.code == 200 else {
        throw ErrorHandler.ErrorType.errorAccessingTheAPI
      }
      
      let warningText = coffeeShopData.response.warning?.text
      
      // TODO: Check whether this could ever be nil / zero and handle appropriately (e.g. searching in the sea)... might not even be needed as we can return nil...
      let items = coffeeShopData.response.groups[0].items
            
//      guard items != nil else {
//        throw ErrorHandler.ErrorType.zeroResultsReturned
//      }
      
      var coffeeShops: [CoffeeShop] = []
      
      for item in items {
        let name = item.venue.name
        let latitude = item.venue.location.lat
        let longitude = item.venue.location.lng
        let distance = item.venue.location.distance
        
        coffeeShops.append(CoffeeShop(name: name,
                                    location: CLLocation(latitude: latitude, longitude: longitude),
                                    distance: distance))
      }
      
      return (coffeeShops, warningText)
            
    } catch {
      throw ErrorHandler.ErrorType.other
    }
      
  }
  
}
