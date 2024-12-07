//
//  SearchBarView.swift
//  ShopHere
//
//  Created by Munachimso Ugorji on 07/12/2024.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchQuery: String

        var body: some View {
            TextField("Search products", text: $searchQuery)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
        }
}
