//
//  ReportImageCell.swift
//  ArretadasFGC
//
//  Created by Ada 2018 on 03/09/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

class ReportImageCell: UITableViewCell {

	@IBOutlet weak var userImageView: UIImageView!
	@IBOutlet weak var userNameLabel: UILabel!
	
	@IBOutlet weak var reportDateLabel: UILabel!
	@IBOutlet weak var reportTextLabel: UILabel!
	@IBOutlet weak var reportImageView: UIImageView!
	@IBOutlet weak var reportView: UIView!
	
	
	override func awakeFromNib() {
        super.awakeFromNib()
		
		//Rounded corner image user
		userImageView.setCornerRadiusDefault()
		reportImageView.setCornerRadiusDefault()
		reportView.setCornerRadiusDefault()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension UIView {
	func setCornerRadiusDefault() {
		self.layer.masksToBounds = true
		self.layer.cornerRadius = 5
	}
}
