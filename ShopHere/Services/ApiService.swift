//
//  ApiService.swift
//  ShopHere
//
//  Created by Munachimso Ugorji on 07/12/2024.
//

import Foundation
import Combine

protocol APIServiceProtocol {
    func fetchProducts() -> AnyPublisher<[Product], Error>
}

class APIService: APIServiceProtocol {
    private let apiURL: String

    init(apiURL: String) {
        self.apiURL = apiURL
    }

    func fetchProducts() -> AnyPublisher<[Product], Error> {
        guard let url = URL(string: apiURL) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Product].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
