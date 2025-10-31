//
//  PostRepositoryImpl.swift
//  SwiftSocial
//
//  Created by Phyo Myanmar Kyaw on 10/31/25.
//

import Foundation
import FirebaseFirestore

class PostRepositoryImpl: PostRepository {
    
    private let db = Firestore.firestore()
    private var postsCollection: CollectionReference {
        return db.collection("posts")
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
