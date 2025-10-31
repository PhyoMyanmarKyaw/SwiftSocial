//
//  FeedView.swift
//  SwiftSocial
//
//  Created by Phyo Myanmar Kyaw on 10/31/25.
//

import SwiftUI

struct FeedView: View {
    
    @StateObject private var viewModel: FeedViewModel
    
    init(viewModel: FeedViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            List(viewModel.posts) { post in
                PostRowView(post: post)
            }
            .navigationTitle("Feed")
            .onAppear {
                viewModel.listenForPosts()
            }
        }
    }
}
