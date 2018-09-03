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
        setupLayout()
    }
    
    func setupLayout(){
        //club image corner radius
        self.clubImage.clipsToBounds = true
        self.clubImage.layer.cornerRadius = 10
        
        //container corner radius and shadow
        self.container.layer.cornerRadius = 5
        self.container.layer.shadowColor = #colorLiteral(red: 0.4390000105, green: 0.4390000105, blue: 0.4390000105, alpha: 1)
        self.container.layer.shadowRadius = 1
        self.container.layer.shadowOpacity = 0.3
        self.container.layer.shadowOffset = CGSize.init(width: 4.0, height: 4.0)
    }
}
