//
//  AuthEntryView.swift
//  SwiftSocial
//
//  Created by Phyo Myanmar Kyaw on 10/27/25.
//

import SwiftUI

struct AuthEntryView: View {
    
    let diContainer: DIContainer
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Welcome to SwiftSocial")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                NavigationLink(
                    destination: LoginView(
                        viewModel: diContainer.makeLoginViewModel())) {
                        Text("Login")
                                .font(.headline)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(.blue)
                                .cornerRadius(10)
                    }
                
                NavigationLink(destination: SignUpView(
                    viewModel: diContainer.makeSignUpViewModel()
                )) {
                   Text("Create Account")
                        .font(.headline)
                        .foregroundStyle(.blue)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10)
                            .stroke(.blue, lineWidth: 1))
                }
            }
            .padding()
        }
    }
}

#Preview {
    AuthEntryView(diContainer: DIContainer())
}
