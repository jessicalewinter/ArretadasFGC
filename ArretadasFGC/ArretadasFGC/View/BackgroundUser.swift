//
//  BackgroundUser.swift
//  ArretadasFGC
//
//  Created by Ada 2018 on 30/08/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

class BackgroundUser: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    override func awakeFromNib() {
        self.setupLayout()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("BackgroundUser", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
    }
    func setupLayout(){
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 5
    }
}
