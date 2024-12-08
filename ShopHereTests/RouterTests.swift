//
//  RouterTests.swift
//  ShopHereTests
//
//  Created by Munachimso Ugorji on 08/12/2024.
//

import XCTest
@testable import ShopHere


final class RouterTests: XCTestCase {
    var router: Router!

    override func setUp() {
        super.setUp()
        router = Router()
    }

    override func tearDown() {
        router = nil
        super.tearDown()
    }

    func testNavigateToProductDetail() {
        let product = Product(id: 1, name: "Test Product", description: "Test Description", price: 10.0, currencyCode: "USD", currencySymbol: "$", quantity: 1, imageLocation: "", status: "available")

        router.navigate(to: .productDetail, with: product)

        XCTAssertEqual(router.currentScreen, .productDetail)
        XCTAssertEqual(router.selectedProduct, product)
    }

    func testResetNavigation() {
        router.navigate(to: .productDetail, with: nil)

        router.reset()

        XCTAssertEqual(router.currentScreen, .productList)
        XCTAssertNil(router.selectedProduct)
    }
}
