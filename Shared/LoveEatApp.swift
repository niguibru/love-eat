//
//  LoveEatApp.swift
//  Shared
//
//  Created by Nicolas Brucchieri on 28/03/2021.
//

import SwiftUI
import Firebase

@main
struct LoveEatApp: App {
    //@StateObject private var dishListViewModel = DishListViewModel(dishRepository: DishGithubRepository())
    @StateObject private var dishListViewModel = DishListViewModel(dishRepository: DishFirebaseRepository())
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            DishListView(viewModel: dishListViewModel)
                .environment(\.colorScheme, .light)
        }
    }
}
