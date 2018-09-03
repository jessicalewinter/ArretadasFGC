//
//  ClubViewController.swift
//  ArretadasFGC
//
//  Created by Ada 2018 on 29/08/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

class ProfileClubViewController: UIViewController {
	
	//Outlets
	@IBOutlet weak var clubNameLabel: UILabel!
	@IBOutlet weak var clubLocationLabel: UILabel!
	@IBOutlet weak var clubImageView: UIImageView!
	@IBOutlet weak var iconLocationImageView: UIImageView!
	@IBOutlet weak var joinButton: PrimaryButton!
	@IBOutlet weak var tableView: UITableView!
	
	
	var club : Club?
//	var reports: [ExperienceReports] = []
//	var members: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()
//		reports = club.expReports?.allObjects as! [ExperienceReports]
//		members = club.members?.allObjects as! [User]
		
		//Set delegates and datasources of tableview
		tableView.delegate = self
		tableView.dataSource = self
		
		tableView.register(UINib(nibName: "ProfileUserTableViewFirstCell", bundle: nil), forCellReuseIdentifier: "cellProfileClub")

		club = Club(context: DataManager.getContext())
	
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
}

extension ProfileClubViewController : UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {		return 4
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cellProfileClub", for: indexPath)

		return cell
	}
}


