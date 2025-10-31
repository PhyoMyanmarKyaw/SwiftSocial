//
//  PostRowView.swift
//  SwiftSocial
//
//  Created by Phyo Myanmar Kyaw on 10/31/25.
//

import SwiftUI

struct PostRowView: View {
    
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("User: \(post.authorUID)")
                .font(.headline)
            
            Text(post.text)
                .font(.body)
            
            Text(post.createdAt, style: .date)
                .font(.caption)
                .foregroundStyle(.gray)
        }
        .padding()
    }
}
