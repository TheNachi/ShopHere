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
    @State private var isLoading = true

    init(viewModel: ProductListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(2)
                        .padding()
                } else {
                    currentView
                }
            }
            .onAppear(perform: loadProducts)
            .onChange(of: viewModel.products) { _, _ in isLoading = false }
            .alert(item: $viewModel.alertItem, content: createAlert)
            .navigationBarTitle(currentTitle, displayMode: .inline)
            .navigationBarItems(leading: backButton, trailing: cartCountButton)
        }
    }

    private var currentView: some View {
        switch router.currentScreen {
        case .productList:
            return AnyView(ProductListView(viewModel: viewModel, router: router))
        case .productDetail:
            if let product = router.selectedProduct {
                return AnyView(ProductDetailView(viewModel: viewModel, product: product))
            }
        }
        return AnyView(EmptyView())
    }

    private var currentTitle: String {
        router.currentScreen == .productList ? "Products" : router.selectedProduct?.name ?? "Product Details"
    }

    private func loadProducts() {
        viewModel.fetchProducts()
        isLoading = true
    }

    private func createAlert(alertItem: AlertItem) -> Alert {
        Alert(
            title: Text(alertItem.title),
            message: Text(alertItem.message),
            dismissButton: .default(Text("OK"))
        )
    }

    private var backButton: some View {
        Button(action: {
            router.reset()
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
