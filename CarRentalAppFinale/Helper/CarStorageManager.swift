//
//  CarStorageManager.swift
//  CarRentalAppFinale
//
//  Created by Ruslan Lahutizada on 29.12.25.
//

import Foundation
import CoreData
import UIKit

final class CarStorageManager {
    
    static let shared = CarStorageManager()
    private init() {}
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func mergeCategories(_ categories: [CarCategory]) {
        
        var addedCars = 0
        
        categories.forEach { category in
            let categoryEntity = fetchOrCreateCategory(category)
            
            category.cars?.forEach { car in
                
                guard let carId = car.id else {
                    return
                }
                let searchComponents: [String] = [
                    car.brand,
                    car.carModel,
                    category.title,
                    car.carDescription,
                    car.modelType,
                    car.rentalPeriod,
                    car.rentalPrice.map { String($0) }
                ].compactMap { $0 }
                
                let searchText = searchComponents
                    .joined(separator: " ")
                    .lowercased()
                
                if let existing = fetchCar(by: carId) {
                    existing.searchText = searchText
                    return
                }
                
                let carEntity = CarEntity(context: context)
                carEntity.id = carId
                carEntity.brand = car.brand
                carEntity.carModel = car.carModel
                carEntity.modelType = car.modelType
                carEntity.carImage = car.carImage
                carEntity.rentalPrice = car.rentalPrice ?? 0
                carEntity.rentalPeriod = car.rentalPeriod
                carEntity.carDescription = car.carDescription
                carEntity.searchText = searchText
                carEntity.isFavorite = false
                carEntity.category = categoryEntity
                
                addedCars += 1
                
            }
        }
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchCategories() -> [CategoryEntity] {
        let request: NSFetchRequest<CategoryEntity> =
        CategoryEntity.fetchRequest()
        return (try? context.fetch(request)) ?? []
    }
    
    func fetchAllCars() -> [CarEntity] {
        let request: NSFetchRequest<CarEntity> =
        CarEntity.fetchRequest()
        return (try? context.fetch(request)) ?? []
    }
    func fetchFavorites() -> [CarEntity] {
        let request: NSFetchRequest<CarEntity> = CarEntity.fetchRequest()
        request.predicate = NSPredicate(format: "isFavorite == YES")
        
        let result = (try? context.fetch(request)) ?? []
        print("📦 fetchFavorites result:", result.count)
        
        return result
    }
    func toggleFavorite(for car: CarEntity) {
        print("⭐️ BEFORE:", car.isFavorite)
        
        car.isFavorite.toggle()
        
        print("⭐️ AFTER:", car.isFavorite)
        
        do {
            try context.save()
            print("💾 saved")
        } catch {
            print("❌ save error", error)
        }
    }
    private func fetchCar(by id: String) -> CarEntity? {
        let request: NSFetchRequest<CarEntity> = CarEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        request.fetchLimit = 1
        return (try? context.fetch(request))?.first
    }
    
    private func fetchOrCreateCategory(_ category: CarCategory) -> CategoryEntity {
        let request: NSFetchRequest<CategoryEntity> = CategoryEntity.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", category.title ?? "")
        request.fetchLimit = 1
        
        if let existing = (try? context.fetch(request))?.first {
            existing.categoryImage = category.categoryImage
            return existing
        }
        
        let entity = CategoryEntity(context: context)
        entity.title = category.title
        entity.categoryImage = category.categoryImage
        return entity
    }
    
    func searchCars(query: String) -> [CarEntity] {
        
        let request: NSFetchRequest<CarEntity> = CarEntity.fetchRequest()
        
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            return fetchAllCars()
        }
        
        request.predicate = NSPredicate(
            format: "searchText CONTAINS[cd] %@",
            trimmed.lowercased()
        )
        
        return (try? context.fetch(request)) ?? []
    }
}
