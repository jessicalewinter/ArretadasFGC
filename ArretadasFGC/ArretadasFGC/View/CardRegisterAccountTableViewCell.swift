//
//  CardRegisterAccountTableViewCell.swift
//  ArretadasFGC
//
//  Created by Ada 2018 on 31/08/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

class CardRegisterAccountTableViewCell: UITableViewCell {

    @IBOutlet weak var labelRegisterAccount: UILabel!
    @IBOutlet weak var textFieldRegisterAccount: UITextField!
    @IBOutlet weak var labelRequired: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setupLayout(tableView: UITableView, cornerRadius: CGFloat, color: UIColor, shadowRadius: CGFloat, shadowOpacity: Float, shadowOffset: CGSize){
        tableView.clipsToBounds = true
        tableView.layer.cornerRadius = cornerRadius
        tableView.layer.masksToBounds = false
        tableView.layer.shadowColor = UIColor.blue.cgColor
        tableView.layer.shadowRadius = shadowRadius
        tableView.layer.shadowOpacity = shadowOpacity
        tableView.layer.shadowOffset = shadowOffset
    }
    
}
