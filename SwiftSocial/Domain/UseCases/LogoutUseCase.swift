//
//  LogoutUseCase.swift
//  SwiftSocial
//
//  Created by Phyo Myanmar Kyaw on 10/27/25.
//

import Foundation

class LogoutUseCase {
    private let repository: AuthRepository
    
    init(repository: AuthRepository) {
        self.repository = repository
    }
    
    func execute() async -> Result<Void, AuthError> {
        return await repository.logout()
    }
}
