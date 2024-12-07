//
//  ProductListView.swift
//  ShopHere
//
//  Created by Munachimso Ugorji on 07/12/2024.
//

import SwiftUI

struct ProductListView: View {
    @ObservedObject var viewModel: ProductListViewModel

        var body: some View {
            List(filteredProducts) { product in
                NavigationLink(destination: ProductDetailView(viewModel: viewModel, product: product)) {
                    HStack {
                        AsyncImage(url: URL(string: product.imageLocation)) { image in
                            image.resizable().scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 50, height: 50)

                        VStack(alignment: .leading) {
                            Text(product.name)
                                .font(.headline)
                            Text("$\(product.price, specifier: "%.2f")")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .toolbar {
                HStack {
                    Image(systemName: "cart.fill")
                    Text("\(viewModel.cartItemCount)")
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }
        }

        private var filteredProducts: [Product] {
            if viewModel.searchQuery.isEmpty {
                return viewModel.products
            } else {
                return viewModel.products.filter { $0.name.lowercased().contains(viewModel.searchQuery.lowercased()) }
            }
        }
}
