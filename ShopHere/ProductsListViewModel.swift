//
//  ProductsListViewModel.swift
//  ShopHere
//
//  Created by Munachimso Ugorji on 07/12/2024.
//

import Foundation
import Combine

class ProductListViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var cartItems: [Product] = []
    @Published var searchQuery: String = ""

    private var cancellables = Set<AnyCancellable>()
    private let apiService: APIServiceProtocol

    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }

    func fetchProducts() {
        apiService.fetchProducts()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching products: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] products in
                self?.products = products
            })
            .store(in: &cancellables)
    }

    func addToCart(product: Product) {
        cartItems.append(product)
    }

    func removeFromCart(product: Product) {
        cartItems.removeAll { $0.id == product.id }
    }

    var cartItemCount: Int {
        cartItems.count
    }
}
