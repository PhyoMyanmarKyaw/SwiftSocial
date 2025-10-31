//
//  FetchPostsUseCase.swift
//  SwiftSocial
//
//  Created by Phyo Myanmar Kyaw on 10/31/25.
//

import Foundation

class FetchPostsUseCase {
    private let repository: PostRepository
    
    init(repository: PostRepository) {
        self.repository = repository
    }
    
    func execute() -> AsyncStream<Result<[Post], PostError>> {
        return repository.posts
    }
}
