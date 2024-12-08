//
//  MockAPIService.swift
//  ShopHereTests
//
//  Created by Munachimso Ugorji on 08/12/2024.
//

import XCTest
import Combine
@testable import ShopHere

final class MockAPIService: APIServiceProtocol {
    var productsToReturn: [Product] = []
    var errorToReturn: Error?

    func fetchProducts() -> AnyPublisher<[Product], Error> {
        if let error = errorToReturn {
            return Fail(error: error).eraseToAnyPublisher()
        } else {
            return Just(productsToReturn)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
