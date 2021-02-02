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
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    viewModel.viewController = self
    viewModel.delegate = self
  }
  
  // MARK: - Navigation Bar Actions
  @IBAction func getLocationButtonPressed(_ sender: UIBarButtonItem) {
    viewModel.refreshData()
  }
}

// MARK: - TableView Datasource
extension ViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.coffeeShops.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "venueListingCell", for: indexPath) as! VenueListingCell

    let coffeeShop = viewModel.coffeeShops[indexPath.row]
    cell.nameLabel.text = coffeeShop.name
    cell.distanceLabel.text = "\(coffeeShop.distance)"
    
    return cell
  }
}

// MARK: - ViewModel Delegate
extension ViewController: ViewModelDelegate {
  
  func viewModel(_ manager: ViewModel, didUpdateUserLocation: CLLocation) {
    print("The User Location was updated in the ViewController")
  }
  
  func viewModel(_ manager: ViewModel, didUpdateCoffeeShops: [CoffeeShop]) {
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
    print("The Coffee Shop Data was updated in the ViewController")
  }
}
