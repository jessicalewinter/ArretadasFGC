//
//  MemberCollectionViewCell.swift
//  ArretadasFGC
//
//  Created by Ada 2018 on 03/09/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

class MemberCollectionViewCell: UICollectionViewCell {
    
	@IBOutlet weak var memberImageView: UIImageView!
	
	override func awakeFromNib() {
		self.layer.masksToBounds = true
		self.layer.cornerRadius = 5
	}
}
