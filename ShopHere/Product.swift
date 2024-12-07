//
//  Product.swift
//  ShopHere
//
//  Created by Munachimso Ugorji on 07/12/2024.
//

import Foundation

struct Product: Identifiable, Decodable {
    let id: Int
    let name: String
    let description: String
    let price: Double
    let currencyCode: String
    let currencySymbol: String
    let quantity: Int
    let imageLocation: String
    let status: String
}
