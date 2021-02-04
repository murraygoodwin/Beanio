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
  @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
  @IBOutlet weak var loadingOverlay: UIView!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var warningMessageView: UIView!
  @IBOutlet weak var warningText: UILabel!
  @IBOutlet var welcomeOverlay: UIView!
    
  enum ViewMode {
    case standby, loading, welcome
  }
    
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.backgroundColor = .clear
    tableView.accessibilityIdentifier = "coffeeVenuesTableView"
    loadingIndicator.accessibilityIdentifier = "loadingIndicator"
    
    viewModel.viewController = self
    viewModel.delegate = self
    warningText.text = viewModel.warningText
    
    if viewModel.coffeeShops.count == 0 {
      updateUI(mode: .welcome)
    }
  }
  
  // MARK: - User Actions
  @IBAction func getLocationButtonPressed(_ sender: UIBarButtonItem) {
    updateUI(mode: .loading)
    viewModel.refreshData()
  }
  
  @IBAction func searchNearbyButtonPressed(_ sender: UIButton) {
    updateUI(mode: .loading)
    viewModel.refreshData()
  }
  
  // MARK: - UI updates
  private func updateUI(mode: ViewMode) {
    
    DispatchQueue.main.async {
      switch mode {
      
      case .welcome:
        self.view.addSubview(self.welcomeOverlay)
        self.welcomeOverlay.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
          self.welcomeOverlay.heightAnchor.constraint(equalTo: self.view.heightAnchor),
          self.welcomeOverlay.widthAnchor.constraint(equalTo: self.view.widthAnchor)])
        
        self.welcomeOverlay.center = self.view.center
        
      case .standby:
        self.loadingOverlay.removeFromSuperview()
        
      case .loading:
        self.welcomeOverlay.removeFromSuperview()
        
        self.view.addSubview(self.loadingOverlay)
        self.loadingOverlay.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
          self.loadingOverlay.heightAnchor.constraint(equalTo: self.view.heightAnchor),
          self.loadingOverlay.widthAnchor.constraint(equalTo: self.view.widthAnchor)])
        
        self.loadingOverlay.center = self.view.center
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
    // Placeholder to allow for a map update if included.
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
