//
//  ContentView.swift
//  ShopHere
//
//  Created by Munachimso Ugorji on 07/12/2024.
//

import SwiftUI

struct ProductView: View {
    @StateObject private var viewModel: ProductListViewModel
    @StateObject private var router = Router()
    @State private var isLoading = true // Track loading state

    init(viewModel: ProductListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ProgressView() // Show ProgressView while loading
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(2) // You can scale the ProgressView for better visibility
                        .padding()
                } else {
                    switch router.currentScreen {
                    case .productList:
                        ProductListView(viewModel: viewModel, router: router)
                    case .productDetail:
                        if let product = router.selectedProduct {
                            ProductDetailView(viewModel: viewModel, router: router, product: product)
                        }
                    }
                }
            }
            .onAppear {
                viewModel.fetchProducts()
                isLoading = true // Set loading state to true while products are being fetched
            }
            .onChange(of: viewModel.products) { _ in
                isLoading = false // Set loading state to false once products are loaded
            }
            .alert(item: $viewModel.alertItem) { alertItem in
                Alert(title: Text(alertItem.title), message: Text(alertItem.message), dismissButton: .default(Text("OK")))
            }
            .navigationBarTitle(router.currentScreen == .productList ? "Products" : router.selectedProduct?.name ?? "Product Details", displayMode: .inline)
            .navigationBarItems(
                leading: backButton,
                trailing: cartCountButton
            )
        }
    }

    private var backButton: some View {
        Button(action: {
            router.currentScreen = .productList
        }) {
            if router.currentScreen == .productDetail {
                Image(systemName: "arrow.backward")
            }
        }
    }

    private var cartCountButton: some View {
        Button(action: {
            viewModel.showComingSoon()
        }) {
            HStack {
                Image(systemName: "cart")
                Text("\(viewModel.cartItemCount)")
                    .font(.subheadline)
            }
        }
    }
}
