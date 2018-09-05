//
//  PrimaryButton.swift
//  GoodQuote
//
//  Created by Ada 2018 on 22/08/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit


class PrimaryButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    override func awakeFromNib() {
        self.setupLayout()
    }
    
    func setupLayout(){
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.primary.cgColor
        self.titleEdgeInsets = UIEdgeInsets(top: 15.0, left: 5.0, bottom: 15.0, right: 5.0)
        
        self.setTitleColor(UIColor.primary, for: .normal)
    }
}
