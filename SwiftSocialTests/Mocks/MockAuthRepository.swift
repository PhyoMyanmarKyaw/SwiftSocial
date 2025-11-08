//
//  MockAuthRepository.swift
//  SwiftSocial
//
//  Created by Phyo Myanmar Kyaw on 11/7/25.
//

import Foundation
@testable import SwiftSocial

class MockAuthRepository: AuthRepository {
    
    var loginResult: Result<Void, AuthError> = .success(())
    
    func login(withEmail email: String, password: String) async -> Result<Void, AuthError> {
        return loginResult
    }
    
    func SignUp(withEmail email: String, password: String) async -> Result<Void, AuthError> {
        fatalError("Signup function should not be called in this test.")
    }
    
    var authState: AsyncStream<AuthState> {
        fatalError("authState should not be called in this test.")
    }
    
    func logout() async -> Result<Void, AuthError> {
        fatalError("logout function should not be called in this test.")
    }
}


