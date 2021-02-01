//
//  ViewController.swift
//  Beanio
//
//  Created by Murray Goodwin on 29/01/2021.
//

import UIKit
import CoreLocation

final class ViewController: UIViewController {
  
  private var viewModel = ViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.viewController = self
    viewModel.delegate = self
  }
  
  // MARK: - Navigation Bar Actions
  @IBAction func getLocationButtonPressed(_ sender: UIBarButtonItem) {
    viewModel.refreshData()
  }
}

// MARK: - ViewModel Delegate
extension ViewController: ViewModelDelegate {
  
  func viewModel(_ manager: ViewModel, didUpdateUserLocation: CLLocation) {
    print("The User Location was updated in the ViewController")
  }
  
  func viewModel(_ manager: ViewModel, didUpdateCoffeeShops: [CoffeeShopData]) {
    print("The Coffee Shop Data was updated in the ViewController")
  }
}
