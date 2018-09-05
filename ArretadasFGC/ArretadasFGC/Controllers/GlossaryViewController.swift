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
    let searchController = UISearchController(searchResultsController: nil)
    
    //Plist Glossary
    let glossary = Glossary()
    var glossaryWords : [(String, String)] = []
    var filteredWords : [(String, String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        //Delegate and DAtasource
        tableView.delegate = self
        tableView.dataSource = self
        
        //Set up Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Pesquisar por palavras"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        extendedLayoutIncludesOpaqueBars = true
        searchController.delegate = self
        
        //Search Controller style
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = UIColor.primary

        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor(white: 90, alpha: 1.0)]

        
        //Set array of glossary's words
        if let dict = glossary.dictionary {
            for (key, value) in dict {
                let sKey = key as! String
                let sValue = value as! String
                self.glossaryWords.append((sKey,sValue))
            }
            self.glossaryWords =  self.glossaryWords.sorted { $0.0 < $1.0 }
            tableView.reloadData()
        }
        
        //Setup layout
        tableView.setCornerRadiusDefault()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredWords = []
        
        filteredWords = glossaryWords.filter({( key : String, value : String) -> Bool in
            if searchBarIsEmpty() {
                return true
            } else {
                return key.lowercased().contains(searchText.lowercased())
            }
        })
        tableView.reloadData()
    }
    
    func searchBarIsEmpty() -> Bool {
        return self.searchController.searchBar.text?.isEmpty ?? true
    }

}

extension GlossaryViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBarIsEmpty() {
            return (glossary.dictionary?.count)!
        } else {
            return filteredWords.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wordCell", for: indexPath)
        
        if searchBarIsEmpty() {
            cell.textLabel?.text = glossaryWords[indexPath.row].0
            cell.detailTextLabel?.text = glossaryWords[indexPath.row].1
        } else {
            cell.textLabel?.text = filteredWords[indexPath.row].0
            cell.detailTextLabel?.text = filteredWords[indexPath.row].1
        }
        
        return cell
    }
}

extension GlossaryViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

extension GlossaryViewController: UISearchBarDelegate {
    
}

extension GlossaryViewController: UISearchControllerDelegate {
    
}

