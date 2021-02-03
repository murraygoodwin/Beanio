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
  @IBOutlet weak var loadingOverlay: UIView!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var warningMessageView: UIView!
  @IBOutlet weak var warningText: UILabel!
    
  enum ViewMode {
    case standby, loading
  }
    
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.backgroundColor = .clear
    
    viewModel.viewController = self
    viewModel.delegate = self
    warningText.text = viewModel.warningText
  }
  
  // MARK: - Navigation Bar Actions
  @IBAction func getLocationButtonPressed(_ sender: UIBarButtonItem) {
    updateUI(mode: .loading)
    viewModel.refreshData()
  }
  
  private func updateUI(mode: ViewMode) {
    
    DispatchQueue.main.async {
      switch mode {
      case .standby:
        self.loadingOverlay.isHidden = true
      case .loading:
        self.loadingOverlay.isHidden = false
      }
    }
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
    cell.distanceLabel.text = "\(coffeeShop.distance)m"
    cell.roundedTile.layer.cornerRadius = 20

    return cell
  }
}

// MARK: - ViewModel Delegate
extension ViewController: ViewModelDelegate {
  
  func viewModel(_ manager: ViewModel, didUpdateUserLocation: CLLocation) {
    // Placeholder to allow for a map update.
  }
  
  func viewModel(_ manager: ViewModel, didUpdateCoffeeShops: [CoffeeShop]) {
    DispatchQueue.main.async {
      self.updateUI(mode: .standby)
      self.tableView.reloadData()
    }
  }
  
  func viewModel(_ manager: ViewModel, didUpdateWarningText: String?) {
    DispatchQueue.main.async {
      self.warningMessageView.isHidden = didUpdateWarningText == nil ? true : false
      self.warningText.text = didUpdateWarningText
    }
  }
}
