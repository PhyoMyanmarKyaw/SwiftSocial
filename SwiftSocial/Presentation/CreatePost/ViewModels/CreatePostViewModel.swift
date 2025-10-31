//
//  CreatePostViewModel.swift
//  SwiftSocial
//
//  Created by Phyo Myanmar Kyaw on 10/31/25.
//

import Foundation
import Combine

enum CreatePostState: Equatable {
    case idle
    case loading
    case success
    case error(String)
}

@MainActor
class CreatePostViewModel: ObservableObject {
    @Published var postText: String = ""
    @Published private(set) var state: CreatePostState = .idle
    
    private let authorUID: String
    private let createPostUseCase: CreatePostUseCase
    
    init(authorUID: String, createPostUseCase: CreatePostUseCase) {
        self.authorUID = authorUID
        self.createPostUseCase = createPostUseCase
    }
    
    func createPost() async {
        state = .loading
        let result = await createPostUseCase.execute(
            text: postText,
            authorUID: authorUID
        )
        
        switch result {
        case .success:
            state = .success
            Log.message("Successfully created post.")
        case .failure(let error):
            let errorMessage = "Failed to create post. Please try again."
            state = .error(errorMessage)
            Log
                .message(
                    "Failed to create post: \(error.localizedDescription)",
                    level: .error
                )
        }
    }
}
