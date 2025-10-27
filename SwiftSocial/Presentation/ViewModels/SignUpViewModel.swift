//
//  SignUpViewModel.swift
//  SwiftSocial
//
//  Created by Phyo Myanmar Kyaw on 10/27/25.
//

import Foundation
import Combine

class SignUpViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var alertMessage = ""
    @Published var showAlert = false
    
    private let signUpUseCase: SignUpUseCase
    
    init(signUpUseCase: SignUpUseCase) {
        self.signUpUseCase = signUpUseCase
    }
    
    func signUp() async {
        isLoading = true
        
        let result = await signUpUseCase.execute(
            withEmail: email,
            password: password
        )
        
        switch result {
        case .success():
            alertMessage = "Sign up successful! You can now log in."
        case .failure(let error):
            alertMessage = mapError(error)
        }
        
        showAlert = true
        isLoading = false
    }
    
    // domain errors to user friendly string
    private func mapError(_ error: AuthError) -> String {
        switch error {
        case .weakPassword:
            return "The password is too weak. Please use at least 5 characters."
        case .invalidEmail:
            return "The email address is badly formatted."
        case .emailInUse:
            return "The email address is already in use by another account."
        default:
            return "An unexpected error occurred. Please try again."
        }
    }
}
