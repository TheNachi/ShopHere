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
    @Published var searchQuery: String = "" {
        didSet {
            filterProducts()
        }
    }
    @Published var alertItem: AlertItem? = nil
    @Published var filteredProducts: [Product] = []

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
                self?.filterProducts()
            })
            .store(in: &cancellables)
    }

    func addToCart(product: Product) {
        cartItems.append(product)
        alertItem = AlertItem(title: "Cart Update", message: "Added \(product.name) to cart.")
    }

    func removeFromCart(product: Product) {
        cartItems.removeAll { $0.id == product.id }
        alertItem = AlertItem(title: "Cart Update", message: "Removed \(product.name) from cart.")
    }

    var cartItemCount: Int {
        cartItems.count
    }

    func showComingSoon() {
        alertItem = AlertItem(title: "Coming Soon", message: "This feature is coming soon!")
    }

    private func filterProducts() {
        if searchQuery.isEmpty {
            filteredProducts = products
        } else {
            filteredProducts = products.filter { $0.name.lowercased().contains(searchQuery.lowercased()) }
        }
    }
}

