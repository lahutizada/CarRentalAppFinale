//
//  HeaderView.swift
//  CarRentalAppFinale
//
//  Created by Ruslan Lahutizada on 29.12.25.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var headerTitle: UILabel!
    
    var categories: [CategoryEntity] = []
        var selectedIndex: Int = 0
        var onCategorySelect: ((CategoryEntity) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
                
        collection.delegate = self
        collection.dataSource = self
        
        collection.contentInset = UIEdgeInsets(
             top: 0,
             left: 0,
             bottom: 0,
             right: 30
         )
        collection.register(
            UINib(nibName: "CaterogyCell", bundle: nil),
            forCellWithReuseIdentifier: "CaterogyCell")
    }
    
    func configure(categories: [CategoryEntity]) {
        self.categories = categories
         collection.reloadData()
    }
}

extension HeaderView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CaterogyCell",
            for: indexPath
        ) as! CaterogyCell

        let category = categories[indexPath.item]
        cell.configure(
            with: category,
            isSelected: indexPath.item == selectedIndex
        )

        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        selectedIndex = indexPath.item
        let category = categories[indexPath.item]
        onCategorySelect?(category)
        collectionView.reloadData()
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: 151, height: 161)
    }
}
