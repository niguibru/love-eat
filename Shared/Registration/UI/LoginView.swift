//
//  LoginView.swift
//  LoveEat (iOS)
//
//  Created by Nicolas Brucchieri on 15/04/2021.
//

import SwiftUI
import Combine

struct SignUpView: View {
    @ObservedObject var viewModel: SignUpViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 16){
            TextField("username", text: $viewModel.email)
            TextField("password", text: $viewModel.password)
            Button("Sign Up") {
                print("User: \(self.viewModel.email)")
                print("Pass: \(self.viewModel.password)")
                viewModel.signUpPressed()
            }
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
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
    
    static var previews: some View {
        SignUpView(
            viewModel: SignUpViewModel(
                signUpUseCase: Mock_SignUp(),
                navigateToLoginUseCase: Mock_NavigateToLoginUseCase()
            )
        )
    }
}
