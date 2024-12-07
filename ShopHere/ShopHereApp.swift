//
//  ShopHereApp.swift
//  ShopHere
//
//  Created by Munachimso Ugorji on 07/12/2024.
//

import SwiftUI
import Swinject

@main
struct ShopHereApp: App {
    let container: Container
        init() {
            container = Container()
            let assembler = Assembler([AppAssembly()], container: container)
        }

        var body: some Scene {
            WindowGroup {
                if let viewModel = container.resolve(ProductListViewModel.self) {
                    ProductView(viewModel: viewModel)
                } else {
                    Text("Failed to resolve dependencies")
                }
            }
        }
}
