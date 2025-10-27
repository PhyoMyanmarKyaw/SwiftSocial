//
//  AuthRepositoryImpl.swift
//  SwiftSocial
//
//  Created by Phyo Myanmar Kyaw on 10/27/25.
//

import Foundation
import FirebaseAuth

class AuthRepositoryImpl: AuthRepository {
    
    func SignUp(withEmail email: String, password: String) async -> Result<Void, AuthError> {
        
        do {
            try await Auth
                .auth()
                .createUser(withEmail: email, password: password)
            return .success(())
            
        } catch let error as NSError {
            
            Log.message("Firebase sign up failed: \(error.localizedDescription)", level: .error)
            
            switch AuthErrorCode(rawValue: error.code) {
            case .invalidEmail:
                return .failure(.invalidEmail)
            case .emailAlreadyInUse:
                return .failure(.emailInUse)
            case .weakPassword:
                return .failure(.weakPassword)
            default:
                return .failure(.unknown)
            }
        }
    }
}
