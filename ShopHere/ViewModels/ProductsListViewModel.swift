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
            .sink(receiveCompletion: handleCompletion, receiveValue: handleReceivedProducts)
            .store(in: &cancellables)
    }

    func addToCart(product: Product) {
        cartItems.append(product)
        showAlert(title: "Cart Update", message: "Added \(product.name) to cart.")
    }

    func removeFromCart(product: Product) {
        cartItems.removeAll { $0.id == product.id }
        showAlert(title: "Cart Update", message: "Removed \(product.name) from cart.")
    }

    var cartItemCount: Int {
        cartItems.count
    }

    func showComingSoon() {
        showAlert(title: "Coming Soon", message: "This feature is coming soon!")
    }

    private func filterProducts() {
        filteredProducts = searchQuery.isEmpty ? products : products.filter { $0.name.lowercased().contains(searchQuery.lowercased()) }
    }

    private func handleCompletion(_ completion: Subscribers.Completion<Error>) {
        if case let .failure(error) = completion {
            print("Error fetching products: \(error)")
            showAlert(title: "Error", message: "Error fetching products")
        }
    }

    private func handleReceivedProducts(_ products: [Product]) {
        self.products = products
        filterProducts()
    }

    private func showAlert(title: String, message: String) {
        alertItem = AlertItem(title: title, message: message)
    }
}
