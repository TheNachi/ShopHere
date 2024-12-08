//
//  ProductListViewModelTests.swift
//  ShopHereTests
//
//  Created by Munachimso Ugorji on 08/12/2024.
//

import XCTest
import Combine
@testable import ShopHere

final class ProductListViewModelTests: XCTestCase {
    var viewModel: ProductListViewModel!
    var mockAPIService: MockAPIService!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        viewModel = ProductListViewModel(apiService: mockAPIService)
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        mockAPIService = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchProductsSuccess() {
        let expectedProducts = [Product(id: 1, name: "Test Product", description: "Test Description", price: 10.0, currencyCode: "USD", currencySymbol: "$", quantity: 1, imageLocation: "", status: "available")]
        mockAPIService.productsToReturn = expectedProducts

        let expectation = XCTestExpectation(description: "Fetch products successfully")

        viewModel.fetchProducts()

        viewModel.$products
            .sink { products in
                XCTAssertEqual(products, expectedProducts)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2.0)
    }

    func testFetchProductsFailure() {
        mockAPIService.errorToReturn = URLError(.badServerResponse)

        let expectation = XCTestExpectation(description: "Handle error during product fetching")

        viewModel.fetchProducts()

        viewModel.$alertItem
            .sink { alert in
                if let alert = alert {
                    XCTAssertEqual(alert.title, "Error")
                    XCTAssertEqual(alert.message, "Error fetching products")
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2.0)
    }

    func testAddToCart() {
        let product = Product(id: 1, name: "Test Product", description: "Test Description", price: 10.0, currencyCode: "USD", currencySymbol: "$", quantity: 1, imageLocation: "", status: "available")

        viewModel.addToCart(product: product)

        XCTAssertTrue(viewModel.cartItems.contains(product))
        XCTAssertEqual(viewModel.cartItemCount, 1)
    }

    func testRemoveFromCart() {
        let product = Product(id: 1, name: "Test Product", description: "Test Description", price: 10.0, currencyCode: "USD", currencySymbol: "$", quantity: 1, imageLocation: "", status: "available")
        viewModel.addToCart(product: product)

        viewModel.removeFromCart(product: product)

        XCTAssertFalse(viewModel.cartItems.contains(product))
        XCTAssertEqual(viewModel.cartItemCount, 0)
    }

    func testSearchProducts() {
        viewModel.products = [
            Product(id: 1, name: "Apple", description: "Fresh apple", price: 1.0, currencyCode: "USD", currencySymbol: "$", quantity: 10, imageLocation: "", status: "available"),
            Product(id: 2, name: "Banana", description: "Fresh banana", price: 1.0, currencyCode: "USD", currencySymbol: "$", quantity: 10, imageLocation: "", status: "available")
        ]

        viewModel.searchQuery = "Apple"

        XCTAssertEqual(viewModel.filteredProducts.count, 1)
        XCTAssertEqual(viewModel.filteredProducts.first?.name, "Apple")
    }
}
