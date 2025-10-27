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
    
    // inject usecase
    
    func signUp() {
        Log.message("ViewModel: Sign up action triggered.")
        // call usecase
        self.alertMessage = "Sign Up feature is in development"
        self.showAlert = true
    }
}
