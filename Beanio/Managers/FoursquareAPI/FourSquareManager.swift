//
//  FourSquareManager.swift
//  Beanio
//
//  Created by Murray Goodwin on 29/01/2021.
//

import Foundation
import CoreLocation

protocol FourSquareMangerDelegate: AnyObject {
  func fourSquareManager(_ manager: FourSquareManager, didFailWithError: ErrorHandler.ErrorType)
}

class FourSquareManager {
  
  weak var delegate: FourSquareMangerDelegate?
  
  // MARK: - Assemble URL
  func assembleURL(baseURL: String, parameters: [String: String]) -> URL? {
    var components = URLComponents(string: baseURL)
    let queryItems = parameters.map { (key, value) -> URLQueryItem in
      URLQueryItem(name: key, value: value)
    }
    components?.queryItems = queryItems
    return components?.url
  }
  
  // MARK: - Download venues
  func downloadVenueDataNearLocation(location: CLLocation, completion: @escaping (Data?) -> ()) {
    
    let baseURL = "https://api.foursquare.com/v2/venues/explore"
    let credentials = Credentials()
    
    guard let url = assembleURL(baseURL: baseURL, parameters: [
                                  "client_id" : credentials.clientID,
                                  "client_secret" : credentials.clientSecret,
                                  "v" : "20210201", // 'Version' - an arbitrary date to be updated periodically when the app is updated.
                                  "section" : "coffee",
                                  "ll" : "\(location.coordinate.latitude),\(location.coordinate.longitude)"]) else {
      
      delegate?.fourSquareManager(self, didFailWithError: .errorAccessingTheAPI)
      return
    }
    
    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: url) { [weak self] (data, response, error) in
      guard let self = self else { return }
      
      guard let data = data, error == nil else {
        self.delegate?.fourSquareManager(self, didFailWithError: .errorAccessingTheAPI)
        return
      }
      completion(data)
    }
    task.resume()
  }
}
