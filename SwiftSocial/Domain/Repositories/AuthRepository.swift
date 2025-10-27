//
//  AuthRepository.swift
//  SwiftSocial
//
//  Created by Phyo Myanmar Kyaw on 10/27/25.
//

import Foundation

// custom error type for our domain
enum AuthError: Error {
    case weakPassword
    case invalidEmail
    case emailInUse
    case serverError(String)
    case unknown
}

protocol AuthRepository {
    func SignUp(withEmail email: String, password: String) async -> Result<Void, AuthError>
}
