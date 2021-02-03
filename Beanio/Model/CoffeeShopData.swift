//
//  CoffeeShop.swift
//  Beanio
//
//  Created by Murray Goodwin on 29/01/2021.
//

import Foundation

struct CoffeeShopData: Decodable {
  
  let meta: Meta
  let response: Response
  
  struct Meta: Decodable {
    let code: Int
  }
  
  struct Response: Decodable {
    let groups: [Group]
    let warning: Warning?
  }
  
  struct Group: Decodable {
    let items: [Item]?
  }
  
  struct Warning: Decodable {
    let text: String?
  }

  struct Item: Decodable {
    let venue: Venue
  }
  
  struct Venue: Decodable {
    let name: String
    let location: Location
  }

  struct Location: Decodable {
    let lat: Double
    let lng: Double
    let distance: Int
  }
  
}
