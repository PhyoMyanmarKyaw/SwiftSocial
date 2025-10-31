//
//  PostRepository.swift
//  SwiftSocial
//
//  Created by Phyo Myanmar Kyaw on 10/31/25.
//

import Foundation

enum PostError: Error {
    case creationFailed(String)
    case unknown
}

protocol PostRepository {
    func createPost(_ post: Post) async -> Result<Void, PostError>
}
