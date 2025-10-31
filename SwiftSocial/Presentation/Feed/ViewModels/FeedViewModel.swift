//
//  FeedViewModel.swift
//  SwiftSocial
//
//  Created by Phyo Myanmar Kyaw on 10/31/25.
//

import Foundation
import Combine

@MainActor
class FeedViewModel: ObservableObject {
    @Published private(set) var posts: [Post] = []
    @Published private(set) var errorMessage: String?
    
    private let fetchPostsUseCase: FetchPostsUseCase
    
    init(fetchPostsUseCase: FetchPostsUseCase) {
        self.fetchPostsUseCase = fetchPostsUseCase
    }
    
    func listenForPosts() {
        Task {
            let stream = fetchPostsUseCase.execute()
            for await result in stream {
                switch result {
                case .success(let posts):
                    self.posts = posts
                    self.errorMessage = nil
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
