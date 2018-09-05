//
//  ClubViewController.swift
//  ArretadasFGC
//
//  Created by Ada 2018 on 29/08/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit
import CoreData

class ProfileClubViewController: UIViewController {
	
	//Outlets labels
	@IBOutlet weak var clubNameLabel: UILabel!
	@IBOutlet weak var clubCityLabel: UILabel!
    @IBOutlet weak var infoBioLabel: UILabel!
    @IBOutlet weak var infoDateLabel: UILabel!
    @IBOutlet weak var infoLocalLabel: UILabel!
    
    //Outlets imageViews
	@IBOutlet weak var clubImageView: UIImageView!
	@IBOutlet weak var iconLocationImageView: UIImageView!
    
    //Outlets views
    @IBOutlet weak var viewInfo: UIView!
    
    //Outlets buttons
    @IBOutlet weak var joinButton: PrimaryButton!

    //Outlets Tables and Collections
	@IBOutlet weak var usersCollectionView: UICollectionView!
	@IBOutlet weak var tableView: UITableView!
    
    // Outlet others 
	@IBOutlet weak var segmentedControl: CustomSegmentedControl!
	
	//Instances
    var currentUser: User?
	var club : Club?
    var members: [User] {
        guard let m = club?.members?.allObjects as? [User] else{ return []}
        return m
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
		
		//Set delegates and datasources of tableview
		tableView.delegate = self
		tableView.dataSource = self
		
		//Get xibs of reports
		tableView.register(UINib(nibName: "ReportImage", bundle: nil), forCellReuseIdentifier: "cellReportImage")
		tableView.register(UINib(nibName: "ReportText", bundle: nil), forCellReuseIdentifier: "cellReportText")
		tableView.register(UINib(nibName: "ReportAudio", bundle: nil), forCellReuseIdentifier: "cellReportAudio")

        //Set data
        setLabelsValues()
        
        //Set layout
        joinButton.primaryButtton()
        clubImageView.setCornerRadiusDefault()
        viewInfo.setCornerRadiusDefault()
        self.currentUser = LoginManager.getUserLogged()
        if self.currentUser != nil{
            if ProfileClub.isAMember(user: self.currentUser!, members: members){
                self.joinButton.setTitle("Participando", for: .normal)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        sizeHeader()
    }
	
    //returns true if the current user is a member of this club
//    func isAMember(user: User) -> Bool{
//        return members.contains(user)
//    }
    
    //adjusting the size of tableview header
    func sizeHeader(){
        guard let headerView = tableView.tableHeaderView else {
            return
        }
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        var frame = headerView.frame
        frame.size.height = self.view.frame.size.height*0.55
        headerView.frame = frame
        
        tableView.tableHeaderView = headerView
    }
    
    
    func setLabelsValues() {
        self.clubNameLabel.text = club?.name
        self.clubCityLabel.text = club?.city
        self.infoLocalLabel.text = club?.local
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
	
	@IBAction func valueChanged(_ sender: CustomSegmentedControl) {
		sender.changeSelectedIndex(to: sender.selectedSegmentIndex)
	}
	
    
    @IBAction func joinClub(_ sender: PrimaryButton) {
        //TODO: ver se tá logado
        if self.currentUser != nil{
            if ProfileClub.isAMember(user: self.currentUser!, members: members) {
                print("nao")
                let alert: UIAlertController = UIAlertController(title: "Deixar clube", message: "Deseja deixar o clube?", preferredStyle: .alert)
                
                let noAction = UIAlertAction(title: "Não", style: .cancel, handler: nil)
                let yesAction = UIAlertAction(title: "Sim", style: .default) { (_) in
                    self.joinButton.titleLabel?.text = "Participar"
                    self.currentUser!.removeFromClubs(self.club!)
                    self.usersCollectionView.reloadData()
                }
                alert.addAction(noAction)
                alert.addAction(yesAction)
                self.present(alert, animated: true, completion: nil)
            }else{
                print("sim")
                self.joinButton.setTitle("Participando", for: .normal)
                self.currentUser!.addToClubs(club!)
                self.usersCollectionView.reloadData()
            }
        }else{
            let alert: UIAlertController = UIAlertController(title: "Você não está logad@ ainda", message: "É preciso está cadastrada para criar um clube", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
            let logginAction = UIAlertAction(title: "Logar", style: .default) { (_) in
                //self.performSegue(withIdentifier: "login", sender: nil)
            }
            alert.addAction(cancelAction)
            alert.addAction(logginAction)
            self.present(alert, animated: true, completion: nil)
            
        }
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
		
		if let imagePath = self.members[indexPath.row].photo {
			cell.memberImageView.image = StoreMidia.loadImageFromPath(imagePath)
		} else {
			cell.memberImageView.image =  #imageLiteral(resourceName: "userDefault")
		}
		
		return cell
	}
}


