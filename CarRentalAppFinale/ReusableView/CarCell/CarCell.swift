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
    @IBOutlet weak var favoriteButton: UIButton!
    
    var onFavoriteTap: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()

    }

    override func prepareForReuse() {
        super.prepareForReuse()
        onFavoriteTap = nil
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
        
        favoriteButton.addTarget(
            self,
            action: #selector(favoriteButtonTapped),
            for: .touchUpInside
        )
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        onFavoriteTap?()
    }
    
    func configure(with car: CarEntity) {
        carBrandLabel.text = car.brand
        brandModelLabel.text = car.carModel
        modelTypeLabel.text = car.modelType
        rentalPeriodLabel.text = car.rentalPeriod
        rentalPriceLabel.text = "$\(car.rentalPrice)"
        carDetailsLabel.text = car.carDescription
        carImage.image = UIImage(named: car.carImage ?? "")
        
        let imageName = car.isFavorite ? "star.fill" : "star"
           let image = UIImage(named: imageName)

           favoriteButton.setImage(image, for: .normal)
    }
}
