//
//  AuthRepository.swift
//  SwiftSocial
//
//  Created by Phyo Myanmar Kyaw on 10/27/25.
//

import Foundation

// custom error type for our domain
enum AuthError: Error, Equatable {
    case weakPassword
    case invalidEmail
    case emailInUse
    case wrongPassword
    case userNotFound
    case serverError(String)
    case unknown
    
    case emptyEmail
    case emptyPassword
}

// authenticated user's state
enum AuthState {
    case unknown
    case loggedIn(uid: String)
    case loggedOut
}

protocol AuthRepository {
    func login(withEmail email: String, password: String) async -> Result<Void, AuthError>
    func SignUp(withEmail email: String, password: String) async -> Result<Void, AuthError>
    
    var authState: AsyncStream<AuthState> { get } // emit current auth state
    func logout() async -> Result<Void, AuthError>
}

extension AuthError {
    var userFriendlyMessage: String {
        switch self {
        case .weakPassword:
            return "The password is too weak. Please use at least 6 characters."
        case .emptyEmail:
            return "Please enter your email address"
        case .invalidEmail:
            return "The email address is badly formatted."
        case .emailInUse:
            return "This email address is already in use by another account."
        case .wrongPassword:
            return "Incorrect password. Please try again."
        case .emptyPassword:
            return "Please enter your password"
        case .userNotFound:
            return "No account found with this email address. Please sign up."
        case .serverError(let message):
            return "A server error occurred: \(message)"
        case .unknown:
            return "An unexpected error occurred. Please try again."
        }
    }
}
