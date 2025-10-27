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
    
    init(viewModel: MainAppViewModel, diContainer: DIContainer) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.diContainer = diContainer
    }
    
    var body: some View {
        VStack {
            Text("Welcome! You are logged in.")
                .font(.title)
            
            Button("Logout") {
                Task {
                    await viewModel.logout()
                }
            }
        }
        .padding()
    }
}

#Preview {
    let container = DIContainer()
    MainAppView(viewModel: container.makeMainAppViewModel(), diContainer: container)
}
