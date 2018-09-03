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
    let dbManager = DataManager()
    let fileManager = StoreMidia()
    
    var clubs: [Club] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName: "ClubCardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ClubCardCollectionViewCell")
        layout(collectionView)
        getObjectsFromCoreData()
        
    }
    
    func getObjectsFromCoreData(){
        let entity = dbManager.getEntity(entity: "Club")
        let result = dbManager.getAll(entity: entity)
        if result.success {
            clubs = result.objects as! [Club]
        }else{
            NSLog("Error on fetch clubs")
            
        }
    }
}

func layout(_ collectionView: UICollectionView){
    collectionView.clipsToBounds = true
    collectionView.layer.cornerRadius = 10
//    collectionView.layer.masksToBounds = false
    collectionView.layer.cornerRadius = 5
//    collectionView.layer.shadowColor = #colorLiteral(red: 0.4390000105, green: 0.4390000105, blue: 0.4390000105, alpha: 1)
//    collectionView.layer.shadowRadius = 1
//    collectionView.layer.shadowOpacity = 0.3
//    collectionView.layer.shadowOffset = CGSize.init(width: 4.0, height: 4.0)
    collectionView.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.9882352941, blue: 0.9725490196, alpha: 1)
}

extension ClubsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return clubs.count
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "ClubCardCollectionViewCell", for: indexPath) as! ClubCardCollectionViewCell
        //let club = clubs[indexPath.row]
        //let path = club.photo
//        cell.clubImage.image = fileManager.loadImageFromPath(path!)!
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
