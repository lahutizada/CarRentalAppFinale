//
//  CategoryEntity+CoreDataProperties.swift
//  CarRentalAppFinale
//
//  Created by Ruslan Lahutizada on 29.12.25.
//
//

public import Foundation
public import CoreData


public typealias CategoryEntityCoreDataPropertiesSet = NSSet

extension CategoryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryEntity> {
        return NSFetchRequest<CategoryEntity>(entityName: "CategoryEntity")
    }

    @NSManaged public var categoryImage: String?
    @NSManaged public var categoryTitle: String?
    @NSManaged public var order: Int16
    @NSManaged public var cars: NSSet?

}

// MARK: Generated accessors for cars
extension CategoryEntity {

    @objc(addCarsObject:)
    @NSManaged public func addToCars(_ value: CarEntity)

    @objc(removeCarsObject:)
    @NSManaged public func removeFromCars(_ value: CarEntity)

    @objc(addCars:)
    @NSManaged public func addToCars(_ values: NSSet)

    @objc(removeCars:)
    @NSManaged public func removeFromCars(_ values: NSSet)

}

extension CategoryEntity : Identifiable {

}
