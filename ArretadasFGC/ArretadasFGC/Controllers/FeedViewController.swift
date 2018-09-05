//
//  FeedViewController.swift
//  ArretadasFGC
//
//  Created by Ada 2018 on 29/08/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UIViewControllerTransitioningDelegate {
	
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    
    //Variables
    var clubs: [Club] = []
	var personalPublicReports: [ExperienceReports] = []
	var publicClubsReports: [ExperienceReports] = []
	var myClubsReports: [ExperienceReports] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup delegates and datasources
        tableView.delegate = self
        tableView.dataSource = self
        
        //Setup layouts
        topView.setCornerRadiusDefault()
        
		//fetchClubs()
    }
	

	func fetchClubs(){
        guard let entity = DataManager.getEntity(entity: "Club") else{ return }
		let result = DataManager.getAll(entity: entity)
		if result.success {
			clubs = result.objects as! [Club]
		}else{
			NSLog("Error fetching clubs")
		}
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension FeedViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reportCell",for: indexPath)
        
        if indexPath.row == 0 {
            cell.textLabel?.text = "Página em construção"
            cell.detailTextLabel?.text = "Estamos trabalhando para criar mais funcionalidades para você. Obrigada pela paciência <3"
        } else {
            cell.textLabel?.text = ""
            cell.detailTextLabel?.text = ""
        }
        
        return cell
    }
}
