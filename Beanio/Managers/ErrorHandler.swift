//
//  ErrorHandler.swift
//  Beanio
//
//  Created by Murray Goodwin on 29/01/2021.
//

import Foundation
import UIKit

final class ErrorHandler {
  
  enum ErrorType: Error, CaseIterable {
    case coreLocationError
    case errorAccessingTheAPI
    case locationServicesDisabled
    case locationServicesRestricted
    case zeroResultsReturned
    case other
  }
    
  func presentError(errorType: ErrorType,
                   viewController: UIViewController?) {
    
    guard let viewController = viewController else { return }
    
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

      case .errorAccessingTheAPI:
      errorTitle = "Please check your connection."
      errorMessage = "We were unable to access the FourSquare service. Please make sure your internet connection is working correctly."

    case .zeroResultsReturned:
      errorTitle = "No venues found nearby."
      errorMessage = "We were unable to find any venues near where you searched. Try searching in another location."
      
    case .other:
      errorTitle = "Please accept our apologies."
      errorMessage = "We are currently unable to help you. Hopefully we will be back working again soon. Please look out for future app updates which might help fix the problem."
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

