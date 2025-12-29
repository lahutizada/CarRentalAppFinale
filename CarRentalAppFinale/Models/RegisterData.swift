//
//  RegisterData.swift
//  CarRentalAppFinale
//
//  Created by Ruslan Lahutizada on 29.12.25.
//

import Foundation


struct RegisterData: Codable {
    let name: String?
    let surname: String?
    let email: String?
    let phone: String?
    let birth: String?
    let password: String?
}

