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
        }
    }

    private var productList: some View {
        List(viewModel.filteredProducts) { product in
            Button(action: {
                router.navigate(to: .productDetail, with: product)
            }) {
                productRow(for: product)
            }
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
        .padding(.vertical, 5)
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
