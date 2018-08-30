//
//  ProfileViewController.swift
//  ArretadasFGC
//
//  Created by Ada 2018 on 29/08/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit
import CoreData

class ProfileUserViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var user: User?
    var icons = ["briefcase", "comment", "location"]
    var info: [String] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()

        info = [user?.city ?? "Não Informado", user?.profession ?? "Não Informado", user?.bio ?? "Não Informado" ]
        setupLayout()
	}
    
    func setupLayout(){
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.clipsToBounds = true
        tableView.layer.cornerRadius = 10
    }
	
	
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

extension ProfileUserViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellProfileUser", for: indexPath)
        cell.imageView?.image = UIImage(named: icons[indexPath.row])
        cell.textLabel?.text = info[indexPath.row]
        return cell
    }
    
    
}

