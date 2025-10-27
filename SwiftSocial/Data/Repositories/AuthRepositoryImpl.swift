//
//  AuthRepositoryImpl.swift
//  SwiftSocial
//
//  Created by Phyo Myanmar Kyaw on 10/27/25.
//

import Foundation
import FirebaseAuth
import Combine

class AuthRepositoryImpl: AuthRepository {
    
    // PassthroughSubj as a bridge between Firebase closure-based listener
    private let authStateSubject = CurrentValueSubject<AuthState, Never>(.unknown)
    
    var authState: AsyncStream<AuthState> {
        AsyncStream { continuation in
            // subscribe to subj and yield new values to the stream's continuation
            let cancellable = authStateSubject.sink { authState in
                continuation.yield(authState)
            }
            
            continuation.onTermination = { @Sendable _ in
                cancellable.cancel()
            }
        }
    }
    
    init() {
        listenForAuthStateChanges()
    }
    
    private func listenForAuthStateChanges() {
        Auth.auth().addStateDidChangeListener {[weak self] (_, user) in
            if let user = user {
                // User is signed in
                Log
                    .message(
                        "Auth state changed: User is logged in with UID: \(user.uid)"
                    )
                self?.authStateSubject.send(.loggedIn(uid: user.uid))
            } else {
                // No user is signed in
                Log.message("Auth state changed: User is logged Out")
                self?.authStateSubject.send(.loggedOut)
            }
        }
    }
    
    func logout() async -> Result<Void, AuthError> {
        do {
            try Auth.auth().signOut()
            return .success(())
        } catch {
            Log
                .message(
                    "Firebase logout failed: \(error.localizedDescription)",
                    level: .error
                )
            return .failure(.unknown)
        }
    }
    
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
    
    func login(withEmail email: String, password: String) async -> Result<Void, AuthError> {
        
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
            return .success(())
            
        } catch let error as NSError {
            Log
                .message(
                    "Firebase login failed: \(error.localizedDescription)",
                    level: .error
                )
            
            switch AuthErrorCode(rawValue: error.code) {
            case .invalidEmail:
                return .failure(.invalidEmail)
            case .wrongPassword:
                return .failure(.wrongPassword)
            case .userNotFound, .userDisabled:
                return .failure(.userNotFound)
            default:
                return .failure(.unknown)
            }
        }
    }
}
