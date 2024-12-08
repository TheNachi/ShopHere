//
//  Router.swift
//  ShopHere
//
//  Created by Munachimso Ugorji on 07/12/2024.
//

import Foundation

class Router: ObservableObject {
    @Published var currentScreen: Screen = .productList
    @Published var selectedProduct: Product?

    enum Screen {
        case productList
        case productDetail
    }

    func navigate(to screen: Screen, with product: Product? = nil) {
        currentScreen = screen
        selectedProduct = product
    }

    func reset() {
        navigate(to: .productList)
    }
}
