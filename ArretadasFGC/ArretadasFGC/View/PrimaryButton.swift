//
//  PrimaryButton.swift
//  GoodQuote
//
//  Created by Ada 2018 on 22/08/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

@IBDesignable

class PrimaryButton: UIButton {

    override func draw(_ rect: CGRect) {
        // Drawing code
		self.layer.masksToBounds = true
		self.layer.cornerRadius = 5
		self.titleEdgeInsets = UIEdgeInsets(top: 15.0, left: 5.0, bottom: 15.0, right: 5.0)

		
		self.backgroundColor = UIColor.primary
		self.setTitleColor(UIColor.white, for: .normal)
    }

}
