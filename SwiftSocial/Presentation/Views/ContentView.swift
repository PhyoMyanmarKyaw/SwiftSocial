//
//  ContentView.swift
//  SwiftSocial
//
//  Created by Phyo Myanmar Kyaw on 10/27/25.
//

import SwiftUI

struct ContentView: View {
    
    let diContainer: DIContainer
    @ObservedObject private var authViewModel: AuthViewModel
    
    init(diContainer: DIContainer, authViewModel: AuthViewModel) {
        self.diContainer = diContainer
        self.authViewModel = authViewModel
    }
    
    var body: some View {
        switch authViewModel.authState {
        case .unknown:
            ProgressView()
                .scaleEffect(2)
        case .loggedIn:
            MainAppView(
                viewModel: diContainer.makeMainAppViewModel(),
                diContainer: diContainer
            )
        case .loggedOut:
            AuthEntryView(diContainer: diContainer)
        }
    }
}
