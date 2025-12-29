//
//  MainModel.swift
//  CarRentalAppFinale
//
//  Created by Ruslan Lahutizada on 28.12.25.
//

import Foundation


struct CarCategory: Codable {
    let categoryTitle: String?
    let categoryImage: String?
    let cars: [Car]?
}

struct Car: Codable {
    let id: String?
    let brand: String?
    let carImage: String?
    let carModel: String?
    let modelType: String?
    let rentalPrice: Int?
    let rentalPeriod: String?
    let carDescription: String?
}
