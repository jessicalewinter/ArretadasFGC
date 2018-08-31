//
//  SecondaryButton.swift
//  GoodQuote
//
//  Created by Ada 2018 on 22/08/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

@IBDesignable
class PrimaryButton: UIButton {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
		self.layer.masksToBounds = true
		self.layer.cornerRadius = 5
		self.layer.borderWidth = 1.0
		self.layer.borderColor = UIColor.primary.cgColor
		self.titleEdgeInsets = UIEdgeInsets(top: 15.0, left: 5.0, bottom: 15.0, right: 5.0)
		
		self.setTitleColor(UIColor.primary, for: .normal)
    }

}
