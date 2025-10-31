//
//  MainAppView.swift
//  SwiftSocial
//
//  Created by Phyo Myanmar Kyaw on 10/27/25.
//

import SwiftUI

struct MainAppView: View {
    
    @StateObject private var viewModel: MainAppViewModel
    let diContainer: DIContainer
    
    // get access to the AuthVM to find current user's state
    @StateObject private var authViewModel: AuthViewModel
    @State private var isCreatePostSheetPresented = false
    
    init(viewModel: MainAppViewModel, diContainer: DIContainer) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.diContainer = diContainer
        _authViewModel = StateObject(
            wrappedValue: diContainer.makeAuthViewModel()
        )
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            FeedView(viewModel: diContainer.makeFeedViewModel())
            
            Button(action: {
                isCreatePostSheetPresented = true
            }) {
                Image(systemName: "plus")
                    .font(.title)
                    .padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(Circle())
                    .shadow(radius: 5)
            }
            .padding()
        }
        .navigationTitle("SwiftSocial")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Logout") {
                    Task {
                        await viewModel.logout()
                    }
                }
            }
        }
        .sheet(isPresented: $isCreatePostSheetPresented) {
            if case .loggedIn(let uid) = authViewModel.authState {
                CreatePostView(
                    viewModel: diContainer
                        .makeCreatePostViewModel(authorUID: uid),
                    isPresented: $isCreatePostSheetPresented
                )
            } else {
                Text("You must be logged in to post.")
            }
        }
    }
}

#Preview {
    let container = DIContainer()
    MainAppView(viewModel: container.makeMainAppViewModel(), diContainer: container)
}
