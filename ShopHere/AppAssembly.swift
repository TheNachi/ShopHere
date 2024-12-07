//
//  AppAssembly.swift
//  ShopHere
//
//  Created by Munachimso Ugorji on 07/12/2024.
//

import Foundation
import Swinject

class AppAssembly: Assembly {
    func assemble(container: Container) {
        container.register(APIServiceProtocol.self) { _ in
            APIService(apiURL: "https://my-json-server.typicode.com/carry1stdeveloper/mock-product-api/productBundles")
        }

        container.register(ProductListViewModel.self) { resolver in
            let apiService = resolver.resolve(APIServiceProtocol.self)!
            return ProductListViewModel(apiService: apiService)
        }
    }
}
