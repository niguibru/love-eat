//
//  SignUpUseCase.swift
//  LoveEat (iOS)
//
//  Created by Nicolas Brucchieri on 16/04/2021.
//

import Foundation
import Combine

protocol AuthRepository {
    func signUp(email: String, password: String) -> Future<Void, AuthError>
}

protocol NavigateToHomePageRouter {
    func navigateToHomePage()
}

enum AuthError: Error {
    case credentialsError(message: String)
    case serverError
    
    var localizedDescription: String {
        switch self {
        case .credentialsError(let message):
            return message
        case .serverError:
            return "Error - Try again later"
        }
    }
}

final class SignUpUseCase: SignUpeable {
    
    private let authRepository: AuthRepository
    private let router: NavigateToHomePageRouter
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(
        authRepository: AuthRepository,
        router: NavigateToHomePageRouter
    ) {
        self.authRepository = authRepository
        self.router = router
    }
    
    func signUp(email: String, password: String) -> Future<ErrorMessage?, Never> {
        return Future { [weak self] promise in
            if let error = self?.validateEmailAndPassword(email: email, password: password) {
                promise(.success(error))
                return
            }

            self?.authRepository
                .signUp(email: email, password: password)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        promise(.success(ErrorMessage(message: error.localizedDescription)))
                    case .finished:
                        break
                    }
                }, receiveValue: { [weak self] _ in
                    self?.router.navigateToHomePage()
                    promise(.success(nil))
                })
                .store(in: &self!.cancellables)
        }
    }
    
    func validateEmailAndPassword(email: String, password: String) -> ErrorMessage? {
        if email.isEmpty {
            return ErrorMessage(message: "Email empty")
        }
        if password.isEmpty {
            return ErrorMessage(message: "Password empty")
        }
        return nil
    }
    
}
