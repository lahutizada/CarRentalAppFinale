//
//  Preload.swift
//  CarRentalAppFinale
//
//  Created by Ruslan Lahutizada on 29.12.25.
//

import Foundation

final class PreloadService {

    static func preloadIfNeeded() {

        guard let categories = JSONLoader.loadCategories() else {
            print("JSON not loaded")
            return
        }

        CarStorageManager.shared.mergeCategories(categories)
    }
}
