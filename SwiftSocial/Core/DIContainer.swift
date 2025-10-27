//
//  DIContainer.swift
//  SwiftSocial
//
//  Created by Phyo Myanmar Kyaw on 10/27/25.
//

import Foundation

class DIContainer {
    
    // MARK: - Services
    
    // lazy var - the obj is only created the first time it's needed.
    private lazy var authRepository: AuthRepository = AuthRepositoryImpl()
    
    
    // MARK: - Use Cases
    private lazy var signUpUseCase: SignUpUseCase = SignUpUseCase(
        repository: authRepository
    )
    
    // MARK: - ViewModels (Factories)
    // factory methods for VM , bec > a new instance should be created every time a View is created
    func makeSignUpViewModel() -> SignUpViewModel {
        return SignUpViewModel(signUpUseCase: signUpUseCase)
    }
}
