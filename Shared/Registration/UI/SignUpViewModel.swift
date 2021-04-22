//
//  LoginViewModel.swift
//  LoveEat (iOS)
//
//  Created by Nicolas Brucchieri on 15/04/2021.
//

import Foundation
import Combine
import FirebaseAuth

protocol SignUpeable {
    func signUp(email: String, password: String) -> Future<ErrorMessage?, Never>
}

protocol NavigateToLoginActionable {
    func navigateToLogin()
}

struct ErrorMessage {
    let message: String
}

class SignUpViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: ErrorMessage?
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let signUpUseCase: SignUpeable
    private let navigateToLoginUseCase: NavigateToLoginActionable
    
    init(
        signUpUseCase: SignUpeable,
        navigateToLoginUseCase: NavigateToLoginActionable
    ) {
        self.signUpUseCase = signUpUseCase
        self.navigateToLoginUseCase = navigateToLoginUseCase
    }
    
    func signUpPressed() {
        signUpUseCase
            .signUp(email: email, password: password)
            .assign(to: \.errorMessage, on: self)
            .store(in: &cancellables)
    }
    
    func haveAccountPressed() {
        navigateToLoginUseCase.navigateToLogin()
    }
    
}




/*
 
 /*let email = "niguibru@gmail.com"
 let pass = "nico1234"
 Auth.auth().createUser(withEmail: email, password: pass) { result, error in
     if let error = error {
         print(error)
     } else {
         print("loggeddin")
     }
 }*/
 
class LoginManager {
    
    var stateDidChangeListener: AuthStateDidChangeListenerHandle? = nil
    
    init() {
        stateDidChangeListener = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                // The user's ID, unique to the Firebase project.
                // Do NOT use this value to authenticate with your backend server,
                // if you have one. Use getTokenWithCompletion:completion: instead.
                let uid = user.uid
                let email = user.email
                let photoURL = user.photoURL
                var multiFactorString = "MultiFactor: "
                for info in user.multiFactor.enrolledFactors {
                    multiFactorString += info.displayName ?? "[DispayName]"
                    multiFactorString += " "
                }
                print(uid)
                print(email!)
                print(photoURL ?? "nopic")
                print(multiFactorString)
            }
        }
    }

    deinit {
        Auth.auth().removeStateDidChangeListener(stateDidChangeListener!)
    }
}
*/
