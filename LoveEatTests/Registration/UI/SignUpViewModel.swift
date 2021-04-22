//
//  SignUpViewModel.swift
//  LoveEatTests
//
//  Created by Nicolas Brucchieri on 19/04/2021.
//

import XCTest
import Combine
@testable import LoveEat

class SignUpViewModelTest: XCTestCase {

    func test_loginWithEmailAndPass_success() {
        let signUpUseCase = Mock_SignUp()
        let navigateToLoginUseCase = Mock_NavigateToLoginUseCase()
        let sut = SignUpViewModel(
            signUpUseCase: signUpUseCase,
            navigateToLoginUseCase: navigateToLoginUseCase
        )
        
        sut.signUpPressed()
        
        XCTAssertTrue(signUpUseCase.signUpCalled)
        XCTAssertNil(sut.errorMessage)
    }
    
    func test_loginWithEmailAndPass_useCaseError() {
        let signUpUseCase = Mock_SignUp()
        signUpUseCase.errorMessage = anyErrorMessage()
        let navigateToLoginUseCase = Mock_NavigateToLoginUseCase()
        let sut = SignUpViewModel(
            signUpUseCase: signUpUseCase,
            navigateToLoginUseCase: navigateToLoginUseCase
        )
        
        sut.signUpPressed()
        
        XCTAssertTrue(signUpUseCase.signUpCalled)
        XCTAssertTrue(sut.errorMessage?.message == anyErrorMessage())
    }
    
    func test_haveAccountPressed_navigateToLogin() {
        let signUpUseCase = Mock_SignUp()
        let navigateToLoginUseCase = Mock_NavigateToLoginUseCase()
        let sut = SignUpViewModel(
            signUpUseCase: signUpUseCase,
            navigateToLoginUseCase: navigateToLoginUseCase
        )
        
        sut.haveAccountPressed()
        
        XCTAssertTrue(navigateToLoginUseCase.navigateToLoginCalled)
    }
    
    // MARK: Helpers

    private class Mock_SignUp: SignUpeable {
        var signUpCalled: Bool = false
        var errorMessage: String?
        
        func signUp(email: String, password: String) -> Future<ErrorMessage?, Never> {
            signUpCalled = true
            return Future { [weak self] promise in
                if let errorMessage = self?.errorMessage {
                    promise(.success(ErrorMessage(message: errorMessage)))
                } else {
                    promise(.success(nil))
                }
            }
        }
    }
    
    private class Mock_NavigateToLoginUseCase: NavigateToLoginActionable {
        var navigateToLoginCalled: Bool = false
        
        func navigateToLogin() {
            navigateToLoginCalled = true
        }
    }

    private func anyErrorMessage() -> String {
        return "Error message"
    }
    
}
