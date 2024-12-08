//
//  Router.swift
//  ShopHere
//
//  Created by Munachimso Ugorji on 07/12/2024.
//

import Foundation

class Router: ObservableObject {
    @Published var currentScreen: Screen = .productList
    @Published var selectedProduct: Product? = nil

    enum Screen {
        case productList
        case productDetail
    }

    func navigateToProductDetail(product: Product) {
        selectedProduct = product
        currentScreen = .productDetail
    }

    func navigateToProductList() {
        currentScreen = .productList
        selectedProduct = nil
    }
}
