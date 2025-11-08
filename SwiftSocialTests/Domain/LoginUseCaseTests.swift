//
//  LoginUseCaseTests.swift
//  SwiftSocialTests
//
//  Created by Phyo Myanmar Kyaw on 11/7/25.
//

import XCTest
@testable import SwiftSocial

final class LoginUseCaseTests: XCTestCase {
    
    var loginUseCase: LoginUseCase!
    var mockAuthRepository: MockAuthRepository!

    override func setUp() {
        super.setUp()
        
        mockAuthRepository = MockAuthRepository()
        loginUseCase = LoginUseCase(repository: mockAuthRepository)
        
    }

    override func tearDown() {
        //clean up
        loginUseCase = nil
        mockAuthRepository = nil
        
        super.tearDown()
    }
    
    func test_LoginUseCase_WhenLoginSucceeds_ShouldReturnSuccess() async {
        // Given
        mockAuthRepository.loginResult = .success(())
        
        // When
        let result = await loginUseCase.execute(withEmail: "test@example.com", password: "password")
        
        // Then
        if case .failure(_) = result {
            XCTFail("Expected success but got failure.")
        }
    }
    
    func test_LoginUseCase_WhenLoginFails_ShouldReturnFailure() async {
        // Given
        mockAuthRepository.loginResult = .failure(.wrongPassword)
        
        // When
        let result = await loginUseCase.execute(withEmail: "test@example.com", password: "password")
        
        // Then
        switch result {
        case .success:
            XCTFail("Expected failure but got success.")
        case .failure(let error):
            XCTAssertEqual(error, .wrongPassword)
        }
    }
    
    func test_LoginUseCase_WhenEamilIsEmpty_ShouldReturnEmptyEmailError() async {
        // Given
        let email = ""
        let password = "password"
        
        // When
        let result = await loginUseCase.execute(
            withEmail: email,
            password: password
        )
        
        // Then
        if case .failure(let error) = result {
            XCTAssertEqual(
                error,
                .emptyEmail,
                "Expected .emptyEmail error but got \(error)")
        } else {
            XCTFail("Expected failure for empty email but got success.")
        }
    }
    
    func test_LoginUseCase_WhenEmailFormatIsInvalid_ShouldReturnInvalidEmailError() async {
        // Given
        let invalidEmail = "test-invalid-email"
        
        // When
        let result = await loginUseCase.execute(
            withEmail: invalidEmail,
            password: "password"
        )
        
        // Then
        if case .failure(let error) = result {
            XCTAssertEqual(error, .invalidEmail, "Expected .invalidEmail error but got \(error)")
        } else {
            XCTFail("Expected failure for invalid email format but got success.")
        }
    }
    
    func test_LoginUseCase_WhenPasswordIsEmpty_ShouldReturnEmptyPasswordError() async {
        // Given
        let email = "test@example.com"
        let password = ""
        
        // When
        let result = await loginUseCase.execute(
            withEmail: email,
            password: password
        )
        
        // Then
        if case .failure(let error) = result {
            XCTAssertEqual(
                error,
                .emptyPassword,
                "Expected .emptyPassword error but got \(error)"
            )
        } else {
            XCTFail("Expected failure for empty password but got success.")
        }
    }
}
