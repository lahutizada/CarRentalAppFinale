//
//  CaterogyCell.swift
//  CarRentalAppFinale
//
//  Created by Ruslan Lahutizada on 29.12.25.
//

import UIKit

class CaterogyCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundContainer: UIView!
    @IBOutlet weak var stack: UIStackView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }

    private func setupUI() {
        backgroundContainer.layer.cornerRadius = 16
        backgroundContainer.backgroundColor = .white

        titleLabel.textColor = .loginBlack
        countLabel.textColor = .loginBlack

            categoryImage.contentMode = .scaleAspectFit
        
        }

        func configure(with category: CategoryEntity, isSelected: Bool) {
            
            titleLabel.text = category.title

            let count = category.cars?.count ?? 0
            countLabel.text = "\(count)"

            categoryImage.image = UIImage(named: category.categoryImage ?? "")

            updateSelection(isSelected)
        }

        func updateSelection(_ isSelected: Bool) {
            backgroundContainer.backgroundColor = isSelected
            ? .brandBlue
            : .white

            titleLabel.textColor = isSelected
            ? .white
            : .loginBlack

            countLabel.textColor = isSelected
                ? .white.withAlphaComponent(0.8)
                : .brandGray
        }

        override func prepareForReuse() {
            super.prepareForReuse()
            updateSelection(false)
        }
}
