//
//  CarEntity+CoreDataProperties.swift
//  CarRentalAppFinale
//
//  Created by Ruslan Lahutizada on 29.12.25.
//
//

public import Foundation
public import CoreData


public typealias CarEntityCoreDataPropertiesSet = NSSet

extension CarEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CarEntity> {
        return NSFetchRequest<CarEntity>(entityName: "CarEntity")
    }

    @NSManaged public var brand: String?
    @NSManaged public var carModel: String?
    @NSManaged public var carImage: String?
    @NSManaged public var modelType: String?
    @NSManaged public var rentalPrice: Double
    @NSManaged public var rentalPeriod: String?
    @NSManaged public var carDescription: String?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var id: String?
    @NSManaged public var searchText: String?
    @NSManaged public var category: CategoryEntity?

}

extension CarEntity : Identifiable {

}
