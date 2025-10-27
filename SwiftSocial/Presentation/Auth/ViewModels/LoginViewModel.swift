//
//  LoginViewModel.swift
//  SwiftSocial
//
//  Created by Phyo Myanmar Kyaw on 10/27/25.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var alertMessage = ""
    @Published var showAlert = false
    
    private let loginUseCase: LoginUseCase
    
    init(loginUseCase: LoginUseCase) {
        self.loginUseCase = loginUseCase
    }
    
    func login() async {
        isLoading = true
        
        let result = await loginUseCase.execute(
            withEmail: email,
            password: password
        )
        
        switch result {
        case .success():
            // navigate to main page
            alertMessage = "Login Successful!"
        case .failure(let error):
            alertMessage = error.userFriendlyMessage
        }
        
        showAlert = true
        isLoading = false
    }
}
