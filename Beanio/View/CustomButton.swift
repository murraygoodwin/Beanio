//
//  CustomButton.swift
//  Beanio
//
//  Created by Murray Goodwin on 05/02/2021.
//

import UIKit

@IBDesignable

class CustomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setDefaultStyling()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setDefaultStyling()
    }

   override func prepareForInterfaceBuilder() {
       super.prepareForInterfaceBuilder()
       setDefaultStyling()
   }
  
   func setDefaultStyling() {
    self.layer.cornerRadius = self.frame.height / 2
   }

}
