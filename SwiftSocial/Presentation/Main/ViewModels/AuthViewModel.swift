//
//  AuthViewModel.swift
//  SwiftSocial
//
//  Created by Phyo Myanmar Kyaw on 10/27/25.
//
import Foundation
import Combine

@MainActor
class AuthViewModel: ObservableObject {
    
    @Published private(set) var authState: AuthState = .unknown
    
    private let authRepository: AuthRepository
    
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
        listenToAuthState()
    }
    
    private func listenToAuthState() {
        Task {
            for await newState in self.authRepository.authState {
                self.authState = newState
            }
        }
    }
}
