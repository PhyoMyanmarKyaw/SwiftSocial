//
//  SignUpUseCase.swift
//  SwiftSocial
//
//  Created by Phyo Myanmar Kyaw on 10/27/25.
//

import Foundation

class SignUpUseCase {
    
    private let repository: AuthRepository
    
    init(repository: AuthRepository) {
        self.repository = repository
    }
    
    func execute(withEmail email: String, password: String) async -> Result<Void, AuthError> {
        // if password.count < 8 { return .failure(.weakPassword)
        return await repository.SignUp(withEmail: email, password: password)
    }
}
