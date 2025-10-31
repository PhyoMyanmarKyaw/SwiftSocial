//
//  PostRepositoryImpl.swift
//  SwiftSocial
//
//  Created by Phyo Myanmar Kyaw on 10/31/25.
//

import Foundation
import FirebaseFirestore
import Combine

class PostRepositoryImpl: PostRepository {
    
    private let db = Firestore.firestore()
    private var postsCollection: CollectionReference {
        return db.collection("posts")
    }
    
    private let postsSubject = CurrentValueSubject<Result<[Post], PostError>, Never>(
        .success([])
    )
    
    var posts: AsyncStream<Result<[Post], PostError>> {
        AsyncStream { continuation in
            let cancellable = postsSubject.sink { result in
                continuation.yield(result)
            }
            continuation.onTermination = { @Sendable _ in
                cancellable.cancel()
            }
        }
    }
    
    init() {
        // start listening for post updates
        listenForPostUpdates()
    }
    
    private func listenForPostUpdates() {
        // addSnapshotListner for real time update
        postsCollection.addSnapshotListener { [weak self] (querySnapshot, error) in
            if let error = error {
                Log
                    .message(
                        "Error fetching post updates: \(error.localizedDescription)", level: .error
                    )
                self?.postsSubject
                    .send(.failure(.creationFailed(error.localizedDescription)))
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                self?.postsSubject.send(.success([]))
                return
            }
            
            // Decode the docs into post obj
            var posts = documents.compactMap{ document -> Post? in
                try? document.data(as: Post.self)
            }
            
            // sort by date , newest first
            posts.sort { $0.createdAt > $1.createdAt }
            
            self?.postsSubject.send(.success(posts))
        }
    }
    
    func createPost(_ post: Post) async -> Result<Void, PostError> {
        do {
            try await postsCollection.document(post.id).setData(from: post)
            return .success(())
        } catch {
            Log
                .message(
                    "Error creating post: \(error.localizedDescription)",
                    level: .error)
            return .failure(.creationFailed(error.localizedDescription))
        }
    }
}
