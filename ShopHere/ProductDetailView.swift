//
//  ProductDetailView.swift
//  ShopHere
//
//  Created by Munachimso Ugorji on 07/12/2024.
//

import SwiftUI

struct ProductDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: ProductListViewModel
    let product: Product

    private var isInCart: Bool {
        viewModel.cartItems.contains { $0.id == product.id }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            productImage

            productDetails

            Spacer()

            actionButtons
        }
        .padding()
        .navigationBarBackButtonHidden(false)
    }

    private var productImage: some View {
        AsyncImage(url: URL(string: product.imageLocation)) { image in
            image.resizable().scaledToFit()
        } placeholder: {
            ProgressView()
        }
        .frame(height: 200)
    }

    private var productDetails: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(product.name)
                .font(.title)

            Text("$\(product.price, specifier: "%.2f")")
                .font(.headline)
                .foregroundColor(.gray)

            Text(product.description)
                .font(.body)
        }
    }

    private var actionButtons: some View {
        HStack {
            cartButton

            buyNowButton
        }
    }

    private var cartButton: some View {
        Button(action: toggleCart) {
            Text(isInCart ? "Remove from Cart" : "Add to Cart")
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }

    private var buyNowButton: some View {
        Button(action: {
            viewModel.showComingSoon()
        }) {
            Text("Buy Now")
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }

    private func toggleCart() {
        if isInCart {
            viewModel.removeFromCart(product: product)
        } else {
            viewModel.addToCart(product: product)
        }
    }
}
