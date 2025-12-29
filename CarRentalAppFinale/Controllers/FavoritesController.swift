//
//  FavoritesController.swift
//  CarRentalAppFinale
//
//  Created by Ruslan Lahutizada on 29.12.25.
//

import UIKit

class FavoritesController: UIViewController {
    
    @IBOutlet weak var collection: UICollectionView!
    
    let coreData = CarStorageManager.shared
    var favorites: [CarEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.dataSource = self
        collection.delegate = self
        collection.register(UINib(nibName: "CarCell", bundle: nil),
                            forCellWithReuseIdentifier: "CarCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        favorites = coreData.fetchFavorites()
        collection.reloadData()
    }
    
}

extension FavoritesController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarCell", for: indexPath) as! CarCell
        
        let car = favorites[indexPath.row]
        cell.configure(with: car)
        
        cell.onFavoriteTap = { [weak self] in
            guard let self = self else { return }
            
            self.coreData.toggleFavorite(for: car)
            self.favorites = self.coreData.fetchFavorites()
            collectionView.reloadData()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width - 60
        return CGSize(width: width, height: 355)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 15, left: 30, bottom: 15, right: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        15
    }
    
}
