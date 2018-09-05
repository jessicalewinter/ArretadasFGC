//
//  ClubsViewController.swift
//  ArretadasFGC
//
//  Created by Ada 2018 on 31/08/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

class ClubsViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let searchController = UISearchController(searchResultsController: nil)
    
    let minimumInteritemSpacing: CGFloat = 10
    let minimumLineSpacing:CGFloat = 10
    
    var currentUser: User?
    var selectedClub: Club?
    var clubs: [Club] {
        guard let entity = DataManager.getEntity(entity: "Club") else{ return [] }
        let result = DataManager.getAll(entity: entity)
        if result.success {
            return result.objects as! [Club]
        }
        return []
    }
    var filteredClubs : [Club] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //Set up Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Pesquisar por palavras"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        extendedLayoutIncludesOpaqueBars = true
        searchController.delegate = self
        searchController.searchBar.scopeButtonTitles = ["Nome", "Local"]
        
        //Search Controller style
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = UIColor.primary
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor(white: 90, alpha: 1.0)]
        
        //Setup layout
        collectionView.setCornerRadiusDefault()
        
        self.collectionView.register(UINib(nibName: "ClubCardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ClubCardCollectionViewCell")
        collectionView.allowsSelection = false
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.updateCollectionView()
    }
    
    func updateCollectionView(){
        collectionView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is AddClubViewController{
            let isLogged = UserDefaults.standard.bool(forKey: "isLogged")
            if isLogged {
                let dest = segue.destination as! AddClubViewController
                dest.user = currentUser
            } else {
                let alert: UIAlertController = UIAlertController(title: "Você não está logad@ ainda", message: "É preciso está cadastrada para criar um clube", preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
                let logginAction = UIAlertAction(title: "Logar", style: .default) { (_) in
                    self.performSegue(withIdentifier: "login", sender: nil)
                }
                alert.addAction(cancelAction)
                alert.addAction(logginAction)
                self.present(alert, animated: true, completion: nil)
            }
        }else if segue.destination is ProfileClubViewController{
            let dest = segue.destination as! ProfileClubViewController
            dest.club = self.selectedClub
            dest.currentUser = self.currentUser
        }
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "Nome") {
        searchController.searchBar.placeholder = "Pesquisar por \(scope.lowercased())"
        
        filteredClubs = []
        
        filteredClubs = clubs.filter({( club : Club) -> Bool in
            if searchBarIsEmpty() {
                return true
            } else {
                if scope == "Nome" {
                    if let result = club.name?.lowercased().contains(searchText.lowercased()) {
                        return result
                    } else {
                        return false
                    }
                } else {
                    if let result = club.local?.lowercased().contains(searchText.lowercased()) {
                        return result
                    } else {
                        return false
                    }
                }
            }
        })
        collectionView.reloadData()
    }
    
    func searchBarIsEmpty() -> Bool {
        return self.searchController.searchBar.text?.isEmpty ?? true
    }
    
    @IBAction func addClub(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addClub", sender: nil)
    }
    
    @objc func buttonAction(sender: UIButton){
        selectedClub = clubs[sender.tag]
        performSegue(withIdentifier: "goProfileClub", sender: nil)
    }
    
}

extension ClubsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchBarIsEmpty() {
            return clubs.count
        } else {
            return filteredClubs.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "ClubCardCollectionViewCell", for: indexPath) as! ClubCardCollectionViewCell
        
        let club : Club!
        
        if searchBarIsEmpty() {
            club = clubs[indexPath.row]
        } else {
            club = filteredClubs[indexPath.row]
        }
        
        let path = club.photo
        cell.clubMoreInfoBtn.primaryButtton()
        cell.clubMoreInfoBtn.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        cell.clubMoreInfoBtn.tag = indexPath.row
        cell.clubImage.image = StoreMidia.loadImageFromPath(path!)!
        cell.clubLocation.text = club.city
        cell.clubName.text = club.name
        cell.clubDescription.text = club.descriptionClub
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = self.collectionView.frame.size.width - (minimumInteritemSpacing + minimumLineSpacing)
        return CGSize.init(width: itemWidth, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacing
    }
}

extension ClubsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}

extension ClubsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

extension ClubsViewController: UISearchControllerDelegate {
    
}
