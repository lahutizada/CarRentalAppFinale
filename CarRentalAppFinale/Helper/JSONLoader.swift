//
//  JSONLoader.swift
//  CarRentalAppFinale
//
//  Created by Ruslan Lahutizada on 29.12.25.
//

import Foundation

final class JSONLoader {

    static func loadCategories() -> [CarCategory]? {
        guard
            let url = Bundle.main.url(forResource: "Car", withExtension: "json"),
            let data = try? Data(contentsOf: url)
        else {
            print("❌ JSON file not found in bundle")
            return nil
        }

        do {
            let categories = try JSONDecoder().decode([CarCategory].self, from: data)
            print("✅ Categories decoded:", categories.count)
            return categories
        } catch {
            print("❌ JSON decode error:", error)
            return nil
        }
    }
}
