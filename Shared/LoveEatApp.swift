//
//  LoveEatApp.swift
//  Shared
//
//  Created by Nicolas Brucchieri on 28/03/2021.
//

import SwiftUI
import Firebase
import FirebaseAuth
import Combine

@main
struct LoveEatApp: App {
    //@StateObject private var dishListViewModel = DishListViewModel(dishRepository: DishGithubRepository())
    @StateObject private var dishListViewModel = DishListViewModel(dishRepository: DishFirebaseRepository())
    
    init() {
        FirebaseApp.configure()
    }
    
    private class Mock_SignUp: SignUpeable {
        func signUp(email: String, password: String) -> Future<ErrorMessage?, Never> {
            return Future { promise in
                promise(.success(nil))
            }
        }
    }
    
    private class Mock_NavigateToLoginUseCase: NavigateToLoginActionable {
        func navigateToLogin() {}
    }
    
    var body: some Scene {
        WindowGroup {
            if Auth.auth().currentUser != nil {
                DishListView(viewModel: dishListViewModel)
                .environment(\.colorScheme, .light)
            } else {
                SignUpView(
                    viewModel: SignUpViewModel(
                        signUpUseCase: Mock_SignUp(),
                        navigateToLoginUseCase: Mock_NavigateToLoginUseCase()
                    )
                )
                .environment(\.colorScheme, .light)
            }
        }
    }
}
