//
//  ContentView.swift
//  ShopHere
//
//  Created by Munachimso Ugorji on 07/12/2024.
//

import SwiftUI

struct ProductView: View {
    @StateObject private var viewModel: ProductListViewModel
    
    init(viewModel: ProductListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            SearchBarView(searchQuery: $viewModel.searchQuery)
            ProductListView(viewModel: viewModel)
        }
        .onAppear {
            viewModel.fetchProducts()
        }
    }
}
