//
//  FeedViewController.swift
//  ArretadasFGC
//
//  Created by Ada 2018 on 29/08/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UIViewControllerTransitioningDelegate {
	
	var clubs: [Club] = []
	var personalPublicReports: [ExperienceReports] = []
	var publicClubsReports: [ExperienceReports] = []
	var myClubsReports: [ExperienceReports] = []

    override func viewDidLoad() {
        super.viewDidLoad()
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
        // Dispose of any resources that can be recreated.
    }
    

//	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//		// UITableView only moves in one direction, y axis
//		var currentOffset: CGFloat = scrollView.contentOffset.y
//		var maximumOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height
//		// Change 50.0 to adjust the distance from bottom
//		if maximumOffset - currentOffset <= 50.0 {
//			if self.yourCoreDataRecordArray.count > 10 {
//				fetchOffSet = fetchOffSet + 10
//				var array: [Any] = self.getCountryFromDB(fetchOffSet)
//			}
//		}
//	}

}
