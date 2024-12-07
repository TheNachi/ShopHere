//
//  ProductDetailView.swift
//  ShopHere
//
//  Created by Munachimso Ugorji on 07/12/2024.
//

import SwiftUI

struct ProductDetailView: View {
    @ObservedObject var viewModel: ProductListViewModel
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            AsyncImage(url: URL(string: product.imageLocation)) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 200)
            
            Text(product.name)
                .font(.title)
            
            Text("$\(product.price, specifier: "%.2f")")
                .font(.headline)
                .foregroundColor(.gray)
            
            Text(product.description)
                .font(.body)
            
            Spacer()
            
            HStack {
                Button(action: {
                    viewModel.addToCart(product: product)
                }) {
                    Text("Add to Cart")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                Button(action: {}) {
                    Text("Buy Now")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
        .padding()
        .navigationTitle(product.name)
    }
}
