//
//  ClubViewController.swift
//  ArretadasFGC
//
//  Created by Ada 2018 on 29/08/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

class ProfileClubViewController: UIViewController {
	
	var club = Club()
	var reports: [ExperienceReports] = []
	var members: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()
		reports = club.expReports?.allObjects as! [ExperienceReports]
		members = club.members?.allObjects as! [User]

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

	

}
