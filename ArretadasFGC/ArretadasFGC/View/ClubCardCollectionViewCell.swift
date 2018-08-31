//
//  ClubCardCollectionViewCell.swift
//  ArretadasFGC
//
//  Created by Ada 2018 on 31/08/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

class ClubCardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var clubImage: UIImageView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var clubName: UILabel!
    @IBOutlet weak var clubLocation: UILabel!
    @IBOutlet weak var clubMoreInfoBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
