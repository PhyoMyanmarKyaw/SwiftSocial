//
//  LoginView.swift
//  SwiftSocial
//
//  Created by Phyo Myanmar Kyaw on 10/27/25.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        
            ZStack {
                VStack(spacing: 20) {
                    Text("Welcome Back")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    TextField("Email", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                    
                    SecureField("Password", text: $viewModel.password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                    
                    Button(action: {
                        Task {
                            await viewModel.login()
                        }
                    }) {
                        Text("Login")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.blue)
                            .cornerRadius(10)
                    }
                    .disabled(viewModel.isLoading)
                    
                    Spacer()
                }
                
                if viewModel.isLoading {
                    ProgressView()
                        .scaleEffect(2)
                }
            }
            .padding()
            .navigationTitle("SwiftSocial")
            .alert("Notice", isPresented: $viewModel.showAlert) {
                Button("OK") {}
            } message: {
                Text(viewModel.alertMessage)
            }
        }
    
}

#Preview {
    let diContainer = DIContainer()
    LoginView(viewModel: diContainer.makeLoginViewModel())
}
