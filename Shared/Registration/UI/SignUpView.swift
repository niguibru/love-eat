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
    
    let imageExample = "https://previews.123rf.com/images/foxysgraphic/foxysgraphic1911/foxysgraphic191100082/134009481-hi-there-banner-speech-bubble-poster-and-sticker-concept-geometric-memphis-style-with-text-hi-there-.jpg"
    
    var body: some View {
        VStack(alignment: .center, spacing: 16){
            AsyncImage(
                url:  URL(string: imageExample)!,
                placeholder: { Image(systemName: "person") },
                image: { Image(uiImage: $0).resizable() }
            )
            .aspectRatio(contentMode: .fill)
            .frame(width: .infinity, height: 200)

            Spacer()
                .frame(height: 16)
            
            TextField("username", text: $viewModel.email)
            TextField("password", text: $viewModel.password)
            
            Button("Sign Up") {
                print("User: \(self.viewModel.email)")
                print("Pass: \(self.viewModel.password)")
                viewModel.signUpPressed()
            }
            
            Spacer()
        }
        .padding()
    }
}

struct SignUpView_Previews: PreviewProvider {
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
