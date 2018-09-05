//
//  GlossaryViewController.swift
//  ArretadasFGC
//
//  Created by Ada 2018 on 31/08/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

class GlossaryViewController: UIViewController {

    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //Plist Glossary
    let glossary = Glossary()
    var glossaryDict : [(String, String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        //Delegate and DAtasource
        tableView.delegate = self
        tableView.dataSource = self
        
        //Set up Search Controller
//        searchBar.delegate = self
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.placeholder = "Search Quotes"
//        navigationItem.searchController = searchController
//        definesPresentationContext = true
//        extendedLayoutIncludesOpaqueBars = true
//        searchController.delegate = self
//        searchController.searchBar.delegate = self
//        searchController.searchBar.tintColor = UIColor(named: "primary")
        
        //Set array of glossary's words
        if let dict = glossary.dictionary {
            for (key, value) in dict {
                let sKey = key as! String
                let sValue = value as! String
                self.glossaryDict.append((sKey,sValue))
                tableView.reloadData()
            }
        }
        
        //Setup layout
        tableView.setCornerRadiusDefault()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension GlossaryViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let length = glossary.dictionary?.count {
            return length
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wordCell", for: indexPath)
        
        cell.textLabel?.text = glossaryDict[indexPath.row].0
        cell.detailTextLabel?.text = glossaryDict[indexPath.row].1
        
        return cell
    }
}

extension GlossaryViewController : UISearchBarDelegate {
    
}
