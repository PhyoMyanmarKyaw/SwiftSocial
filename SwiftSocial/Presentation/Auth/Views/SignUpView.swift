//
//  SignUpView.swift
//  SwiftSocial
//
//  Created by Phyo Myanmar Kyaw on 10/27/25.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject private var viewModel: SignUpViewModel
    
    init(viewModel: SignUpViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        
        
            ZStack {
                VStack(spacing: 20) {
                    
                    Text("Create Account")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    // Email
                    TextField("Email", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                    
                    // Password
                    SecureField("Password", text: $viewModel.password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                    
                    Button(action: {
                        Task {
                            await viewModel.signUp()
                        }
                    }) {
                        Text("Sign Up")
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
                        .progressViewStyle(CircularProgressViewStyle())
                }
            }
            .padding()
            .navigationTitle("Swift Social")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Notice", isPresented: $viewModel.showAlert) {
                Button("OK") { }
            } message: {
                Text(viewModel.alertMessage)
            }
        }
    
}

#Preview {
    let diContainer = DIContainer()
    SignUpView(viewModel: diContainer.makeSignUpViewModel())
}
