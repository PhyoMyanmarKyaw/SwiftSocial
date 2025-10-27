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
            alertMessage = error.userFriendlyMessage
        }
        
        showAlert = true
        isLoading = false
    }
}
