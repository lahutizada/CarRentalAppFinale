//
//  CarCell.swift
//  CarRentalAppFinale
//
//  Created by Ruslan Lahutizada on 28.12.25.
//

import UIKit

class CarCell: UICollectionViewCell {
    
    @IBOutlet weak var leftStack: UIStackView!
    @IBOutlet weak var rightStack: UIStackView!
    @IBOutlet weak var carBrandLabel: UILabel!
    @IBOutlet weak var brandModelLabel: UILabel!
    @IBOutlet weak var modelTypeLabel: UILabel!
    @IBOutlet weak var rentalPriceLabel: UILabel!
    @IBOutlet weak var rentalPeriodLabel: UILabel!
    @IBOutlet weak var carDetailsLabel: UILabel!
    @IBOutlet weak var carImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()

    }

    private func setupUI() {

        layer.cornerRadius = 24
        layer.masksToBounds = false

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.12
        layer.shadowRadius = 12
        layer.shadowOffset = CGSize(width: 0, height: 6)

        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 24
        contentView.layer.masksToBounds = true

        carImage.contentMode = .scaleAspectFit

        rentalPriceLabel.textColor = .brandBlue
        carBrandLabel.textColor = .loginBlack
        brandModelLabel.textColor = .brandGray
        rentalPeriodLabel.textColor = .brandGray
        modelTypeLabel.textColor = .loginBlack
        carDetailsLabel.textColor = .loginBlack
    }
}
