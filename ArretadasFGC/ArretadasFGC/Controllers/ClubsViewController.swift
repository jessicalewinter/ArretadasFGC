//
//  ClubsViewController.swift
//  ArretadasFGC
//
//  Created by Ada 2018 on 31/08/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

class ClubsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let minimumInteritemSpacing: CGFloat = 10
    let minimumLineSpacing:CGFloat = 10
    
    var currentuser: User?
    var clubs: [Club] {
        let entity = DataManager.getEntity(entity: "Club")
        let result = DataManager.getAll(entity: entity)
        if result.success {
            return result.objects as! [Club]
        }
        return []
        
    }
    
    override func viewDidLoad() {
//        DataManager.deleteAll(entity: DataManager.getEntity(entity: "User"))
//        DataManager.deleteAll(entity: DataManager.getEntity(entity: "Club"))
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName: "ClubCardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ClubCardCollectionViewCell")
        layout(collectionView)
        
    }
    
    @IBAction func addClub(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addClub", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is AddClubViewController{
            let isLogged = UserDefaults.standard.bool(forKey: "isLogged")
            if isLogged {
                let dest = segue.destination as! AddClubViewController
                dest.user = currentuser
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
            
            
        }
    }
    
}
    

func layout(_ collectionView: UICollectionView){
    collectionView.clipsToBounds = true
    collectionView.layer.cornerRadius = 10
    collectionView.layer.cornerRadius = 5
    collectionView.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.9882352941, blue: 0.9725490196, alpha: 1)
}

extension ClubsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return clubs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "ClubCardCollectionViewCell", for: indexPath) as! ClubCardCollectionViewCell
//        let club = clubs[indexPath.row]
//        let path = club.photo
//        //cell.clubImage.image = StoreMidia.loadImageFromPath(path!)!
//        cell.clubLocation.text = club.local
//        cell.clubName.text = club.name
//        cell.clubDescription.text = club.descriptionClub
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
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        <#code#>
//    }
}
