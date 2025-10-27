//
//  LoginUseCase.swift
//  SwiftSocial
//
//  Created by Phyo Myanmar Kyaw on 10/27/25.
//

import Foundation

class LoginUseCase {
    
    private let repository: AuthRepository
    
    init(repository: AuthRepository) {
        self.repository = repository
    }
    
    func execute(withEmail email: String, password: String) async -> Result<Void, AuthError> {
        
        guard email.isNotEmpty else { return .failure(.invalidEmail) }
        guard email.isValidEmail else { return .failure(.invalidEmail) }
        guard password.isNotEmpty else { return .failure(.wrongPassword) }
        
        return await repository.login(withEmail: email, password: password)
    }
}
