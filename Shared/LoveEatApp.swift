//
//  LoveEatApp.swift
//  Shared
//
//  Created by Nicolas Brucchieri on 28/03/2021.
//

import SwiftUI

@main
struct LoveEatApp: App {
    @StateObject private var dishListViewModel = DishListViewModel()
    
    var body: some Scene {
        WindowGroup {
            DishListView(viewModel: dishListViewModel)
                .environment(\.colorScheme, .light)
        }
    }
}
