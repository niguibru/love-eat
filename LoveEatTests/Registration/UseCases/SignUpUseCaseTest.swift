//
//  SignUpUseCaseTest.swift
//  LoveEatTests
//
//  Created by Nicolas Brucchieri on 16/04/2021.
//

import XCTest
import Combine
@testable import LoveEat

class SignUpUseCaseTest: XCTestCase {
    
    private var cancellables: Set<AnyCancellable> = []
    
    func test_signUp_withUserAndPass() {
        let authRepository = Mock_AuthRepository()
        let router = Mock_SignUpRouter()
        let sut = SignUpUseCase(
            authRepository: authRepository,
            router: router
        )
        let expectation = self.expectation(description: "signUp")
        var message: ErrorMessage? = nil
        
        sut
            .signUp(email: anyMail(), password: anyPassword())
            .sink(
                receiveCompletion: { _ in
                    expectation.fulfill()
                },
                receiveValue: { receivedValue in
                    message = receivedValue
                }
            )
            .store(in: &cancellables)
        waitForExpectations(timeout: 10)
        
        XCTAssertNil(message)
        XCTAssertTrue(authRepository.signedUp)
        XCTAssertTrue(router.navigatedToHomePage)
    }

    func test_signUp_withEmptyUserAndPass_returnErrorMessage() {
        let authRepository = Mock_AuthRepository()
        let router = Mock_SignUpRouter()
        let sut = SignUpUseCase(
            authRepository: authRepository,
            router: router
        )
        let expectation = self.expectation(description: "signUp")
        var message: ErrorMessage? = nil
        
        sut
            .signUp(email: "", password: anyPassword())
            .sink(
                receiveCompletion: { _ in
                    expectation.fulfill()
                },
                receiveValue: { receivedValue in
                    message = receivedValue
                }
            )
            .store(in: &cancellables)
        waitForExpectations(timeout: 10)
        
        XCTAssertTrue(message!.message == "Email empty")
        XCTAssertFalse(authRepository.signedUp)
        XCTAssertFalse(router.navigatedToHomePage)
    }
    
    func test_signUp_withUserAndEmptyPass_returnErrorMessage() {
        let authRepository = Mock_AuthRepository()
        let router = Mock_SignUpRouter()
        let sut = SignUpUseCase(
            authRepository: authRepository,
            router: router
        )
        let expectation = self.expectation(description: "signUp")
        var message: ErrorMessage? = nil
        
        sut
            .signUp(email: anyMail(), password: "")
            .sink(
                receiveCompletion: { _ in
                    expectation.fulfill()
                },
                receiveValue: { receivedValue in
                    message = receivedValue
                }
            )
            .store(in: &cancellables)
        waitForExpectations(timeout: 10)
        
        XCTAssertTrue(message!.message == "Password empty")
        XCTAssertFalse(authRepository.signedUp)
        XCTAssertFalse(router.navigatedToHomePage)
    }
    
    func test_signUp_withEmptyUserAndEmptyPass_returnErrorMessage() {
        let authRepository = Mock_AuthRepository()
        let router = Mock_SignUpRouter()
        let sut = SignUpUseCase(
            authRepository: authRepository,
            router: router
        )
        let expectation = self.expectation(description: "signUp")
        var message: ErrorMessage? = nil
        
        sut
            .signUp(email: "", password: "")
            .sink(
                receiveCompletion: { _ in
                    expectation.fulfill()
                },
                receiveValue: { receivedValue in
                    message = receivedValue
                }
            )
            .store(in: &cancellables)
        waitForExpectations(timeout: 10)
        
        XCTAssertTrue(message!.message == "Email empty")
        XCTAssertFalse(authRepository.signedUp)
        XCTAssertFalse(router.navigatedToHomePage)
    }
    
    func test_signUp_withUserAndPass_returnErrorMessage() {
        let authRepository = Mock_AuthRepository()
        authRepository.returnError = .serverError
        let router = Mock_SignUpRouter()
        let sut = SignUpUseCase(
            authRepository: authRepository,
            router: router
        )
        let expectation = self.expectation(description: "signUp")
        var message: ErrorMessage? = nil
        
        sut
            .signUp(email: anyMail(), password: anyPassword())
            .sink(
                receiveCompletion: { _ in
                    expectation.fulfill()
                },
                receiveValue: { receivedValue in
                    message = receivedValue
                }
            )
            .store(in: &cancellables)
        waitForExpectations(timeout: 10)
        
        XCTAssertTrue(message!.message == AuthError.serverError.localizedDescription)
        XCTAssertFalse(authRepository.signedUp)
        XCTAssertFalse(router.navigatedToHomePage)
    }

    // MARK: Helpers
 
    private class Mock_AuthRepository: AuthRepository {
        var returnError: AuthError? = nil
        var signedUp: Bool = false
        
        func signUp(email: String, password: String) -> Future<Void, AuthError> {
            return Future { [weak self] promise in
                if let error = self?.returnError {
                    self?.signedUp = false
                    promise(.failure(error))
                } else {
                    self?.signedUp = true
                    promise(.success(()))
                }
            }
        }
    }
    
    private class Mock_SignUpRouter: NavigateToHomePageRouter {
        var navigatedToHomePage: Bool = false
        
        func navigateToHomePage() {
            navigatedToHomePage = true
        }
    }
    
    private func anyMail() -> String {
        return "validmail@mail.com"
    }
    
    private func anyPassword() -> String {
        return "pass"
    }
    
}
