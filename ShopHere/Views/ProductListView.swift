//
//  ProductListView.swift
//  ShopHere
//
//  Created by Munachimso Ugorji on 07/12/2024.
//

import SwiftUI

struct ProductListView: View {
    @ObservedObject var viewModel: ProductListViewModel
    @ObservedObject var router: Router

    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(searchQuery: $viewModel.searchQuery)
                productList
            }
            .padding(.horizontal)
        }
    }

    private var productList: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 10) {
                ForEach(viewModel.filteredProducts) { product in
                    Button(action: {
                        router.navigate(to: .productDetail, with: product)
                    }) {
                        productRow(for: product)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.vertical)
        }
    }

    private func productRow(for product: Product) -> some View {
        HStack {
            productImage(for: product.imageLocation)

            VStack(alignment: .leading) {
                Text(product.name)
                    .font(.headline)
                Text("$\(product.price, specifier: "%.2f")")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()

            if viewModel.cartItems.contains(where: { $0.id == product.id }) {
                Text("In Cart")
                    .font(.footnote)
                    .padding(4)
                    .background(Color.green.opacity(0.2))
                    .cornerRadius(8)
                    .foregroundColor(.green)
            }
        }
    }

    private func productImage(for url: String) -> some View {
        AsyncImage(url: URL(string: url)) { image in
            image.resizable().scaledToFit()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 100, height: 100)
    }
}
