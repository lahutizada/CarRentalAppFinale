//
//  MainController.swift
//  CarRentalAppFinale
//
//  Created by Ruslan Lahutizada on 28.12.25.
//

import UIKit
import CoreData

class MainController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var collection: UICollectionView!
    
    let coreData = CarStorageManager.shared
    var cars: [CarEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cars = coreData.fetchAllCars()
        configureUI()
    }
    
    private func configureUI() {
        
        collection.delegate = self
        collection.dataSource = self
        searchTextField.layer.cornerRadius = 35
        searchTextField.clipsToBounds = true
        searchTextField.tintColor = .white
        searchTextField.setLeftPaddingPoints(30)
        collection.register(
            UINib(nibName: "CarCell", bundle: nil),
            forCellWithReuseIdentifier: "CarCell")
        collection.register(
            UINib(nibName: "HeaderView", bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "HeaderView"
        )
        searchTextField.addTarget(
            self,
            action: #selector(searchChanged),
            for: .editingChanged
        )
    }
    
    @objc private func searchChanged() {
        let text = searchTextField.text ?? ""
        cars = coreData.searchCars(query: text)
        collection.reloadData()
    }
}

extension MainController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CarCell",
            for: indexPath
        ) as! CarCell
        
        let car = cars[indexPath.row]
        cell.configure(with: car)
        
        cell.onFavoriteTap = { [weak self] in
            guard let self = self else { return }
            
            self.coreData.toggleFavorite(for: car)
            
            collectionView.reloadItems(at: [indexPath])
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
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 265)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "\(HeaderView.self)",
            for: indexPath
        ) as! HeaderView
        
        let categories = coreData.fetchCategories()
        header.configure(categories: categories)
        
        header.onCategorySelect = { [weak self] category in
            guard let self = self else { return }
            self.cars = category.cars?.allObjects as? [CarEntity] ?? []
            self.collection.reloadData()
        }
        return header
    }
}

