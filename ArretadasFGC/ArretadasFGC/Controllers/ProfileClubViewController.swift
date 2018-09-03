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
	@IBOutlet weak var clubCityLabel: UILabel!
	@IBOutlet weak var clubImageView: UIImageView!
	@IBOutlet weak var iconLocationImageView: UIImageView!
	@IBOutlet weak var joinButton: PrimaryButton!
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var segmentedControl: CustomSegmentedControl!
	
	@IBOutlet weak var infoBioLabel: UILabel!
	@IBOutlet weak var infoDateLabel: UILabel!
	@IBOutlet weak var usersCollectionView: UICollectionView!
	@IBOutlet weak var infoLocalLabel: UILabel!
	
	@IBOutlet weak var viewInfo: UIView!
	
	//Instance of club
	var club : Club?
	var members: [User] = []
//	var reports: [ExperienceReports] = []

    override func viewDidLoad() {
        super.viewDidLoad()
//		reports = club.expReports?.allObjects as! [ExperienceReports]
//		members = club.members?.allObjects as! [User]
		
		//Set delegates and datasources of tableview
		tableView.delegate = self
		tableView.dataSource = self
		
		//Get xibs of reports
		tableView.register(UINib(nibName: "ReportImage", bundle: nil), forCellReuseIdentifier: "cellReportImage")
		tableView.register(UINib(nibName: "ReportText", bundle: nil), forCellReuseIdentifier: "cellReportText")
		tableView.register(UINib(nibName: "ReportAudio", bundle: nil), forCellReuseIdentifier: "cellReportAudio")
		

		self.club = Club(context: DataManager.getContext())
		
		
		//MOCK
		let user1 = User(context: DataManager.getContext())
		user1.name = "Debora"
		user1.email = "deboramoura@gmail.com"
		user1.photo = nil
		user1.city = "Fortaleza"
		user1.bio = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
		user1.profession = "iOS Developer"
		user1.password = "12345"
		
		let user2 = User(context: DataManager.getContext())
		let user3 = User(context: DataManager.getContext())
		club?.members = [user1,user2,user3]
		
		club?.name = "Clube da Luluzinha"
		club?.local = "Gentilândia"
		club?.city = "Fortaleza"
		club?.dateMeeting = "Seg-Qui 18h"
		club?.descriptionClub = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris sit amet quam vulputate nulla elementum malesuada. Mauris gravida imperdiet dictum."
		club?.photo = nil
		
		//Set variables
		self.members = club?.members?.allObjects as! [User]
		
		setLabelsValues()
		
		clubImageView.setCornerRadiusDefault()
		viewInfo.setCornerRadiusDefault()
		
		
	}
	
	func setLabelsValues() {
		self.clubNameLabel.text = club?.name
		self.clubCityLabel.text = club?.city
		if let imagePath = club?.photo {
			self.clubImageView.image = StoreMidia.loadImageFromPath(imagePath)
		} else {
			self.clubImageView.image =  #imageLiteral(resourceName: "userDefault")
		}
		
		self.infoDateLabel.text = club?.dateMeeting
		self.infoLocalLabel.text = club?.local
		self.infoBioLabel.text = club?.descriptionClub
		
		usersCollectionView.delegate = self
		usersCollectionView.dataSource = self
		
	}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	@IBAction func valueChanged(_ sender: CustomSegmentedControl) {
		sender.changeSelectedIndex(to: sender.selectedSegmentIndex)
	}
	
	
}

extension ProfileClubViewController : UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {		return 3
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cellReportImage", for: indexPath) as! ReportImageCell
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		
		return 270.0
		
	}
	
}

extension ProfileClubViewController : UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.members.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "clubMember", for: indexPath) as! MemberCollectionViewCell
		
		if let imagePath = members[indexPath.row].photo {
			cell.memberImageView.image = StoreMidia.loadImageFromPath(imagePath)
		} else {
			cell.memberImageView.image =  #imageLiteral(resourceName: "userDefault")
		}
		
		return cell
	}
	
	
	
	
}


