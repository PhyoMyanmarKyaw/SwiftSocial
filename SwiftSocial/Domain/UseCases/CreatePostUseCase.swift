//
//  CreatePostUseCase.swift
//  SwiftSocial
//
//  Created by Phyo Myanmar Kyaw on 10/31/25.
//

import Foundation

class CreatePostUseCase {
    
    private let repository: PostRepository
    
    init(repository: PostRepository) {
        self.repository = repository
    }
    
    func execute(text: String, authorUID: String) async -> Result<Void, PostError> {
        guard !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return .failure(.creationFailed("Post cannot be empty."))
        }
        
        let post = Post(id: UUID().uuidString,
                        text: text,
                        authorUID:
                            authorUID,
                        createdAt: Date())
        
        return await repository.createPost(post)
    }
}
