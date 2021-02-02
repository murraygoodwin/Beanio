//
//  VenueListingCell.swift
//  Beanio
//
//  Created by Murray Goodwin on 02/02/2021.
//

import UIKit

class VenueListingCell: UITableViewCell {

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var distanceLabel: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
