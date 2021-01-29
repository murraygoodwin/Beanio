//
//  ErrorHandler.swift
//  Beanio
//
//  Created by Murray Goodwin on 29/01/2021.
//

import Foundation
import UIKit

final class ErrorHandler {
  
  enum ErrorType: Error {
    case coreLocationError
    case locationServicesDisabled
    case locationServicesRestricted
    case other
  }
    
  func handleError(errorType: ErrorType,
                   viewController: UIViewController) {
    
    var errorTitle: String?
    var errorMessage: String?
    
    switch errorType {
    
    case .coreLocationError:
      errorTitle = "We can't find you... 🕵🏻‍♂️"
      errorMessage = "We were unable to find your location.\nYou may wish to try again in a few moments."

    case .locationServicesDisabled:
      errorTitle = "We can't find you... 🕵🏻‍♂️"
      errorMessage = "We were unable to find your location.\nPlease enable Location Services under Settings > Privacy > Location Services so we can find venues nearby."
      
    case .locationServicesRestricted:
      errorTitle = "We can't find you... 🕵🏻‍♂️"
      errorMessage = "We were unable to find your location.\nAccess to Location Services appears to be restricted on your device - perhaps by parental controls or by a company policy? Try searching by entering a place name instead."
      
    case .other:
      errorTitle = "Please accept our apologies."
      errorMessage = "We are currently unable to help you. Hopefully we will be back working again soon. Please look out for future app updates which might help fix the problem."
      
//    case .errorAccessingTheAPI:
//      errorTitle = "Please check your connection."
//      errorMessage = "We were unable to access the weather service. Please make sure your internet connection is working correctly."
//
//
//    case .connectivityIssue:
//      errorTitle = "Please accept our apologies."
//      errorMessage = "We are currently unable to help you. Hopefully we will be back working again soon. Please look out for future app updates which might help fix the problem."
      
    }
    
    if let _ = errorMessage, let errorTitle = errorTitle {
      
      let alert = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Okay", style: .default))
      DispatchQueue.main.async {
        viewController.present(alert, animated: true)
      }
      
    }
  }
}

