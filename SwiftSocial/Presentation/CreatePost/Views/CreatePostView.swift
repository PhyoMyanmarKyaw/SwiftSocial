//
//  CreatePostView.swift
//  SwiftSocial
//
//  Created by Phyo Myanmar Kyaw on 10/31/25.
//
import SwiftUI

struct CreatePostView: View {
    
    @StateObject private var viewModel: CreatePostViewModel
    @Binding var isPresented: Bool
    
    init(viewModel: CreatePostViewModel, isPresented: Binding<Bool>) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _isPresented = isPresented
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                TextEditor(text: $viewModel.postText)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                Spacer()
            }
            .padding()
            .navigationTitle("New Post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
                
                // post button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Post") {
                        Task {
                            await viewModel.createPost()
                        }
                    }
                    .disabled(viewModel.postText.isEmpty || viewModel.state == .loading)
                }
            }
            .onChange(of: viewModel.state) { newState in
                if case .success = newState {
                    isPresented = false
                }
            }
            .overlay {
                if viewModel.state == .loading {
                    ProgressView()
                }
            }
        }
    }
}

