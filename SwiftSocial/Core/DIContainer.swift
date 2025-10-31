//
//  DIContainer.swift
//  SwiftSocial
//
//  Created by Phyo Myanmar Kyaw on 10/27/25.
//

import Foundation

class DIContainer {
    
    // MARK: - Services
    
    // lazy var - the obj is only created the first time it's needed.
    private lazy var authRepository: AuthRepository = AuthRepositoryImpl()
    private lazy var postRepository: PostRepository = PostRepositoryImpl()
    
    // MARK: - Use Cases
    private lazy var signUpUseCase: SignUpUseCase = SignUpUseCase(
        repository: authRepository
    )
    private lazy var loginUseCase: LoginUseCase = LoginUseCase(
        repository: authRepository
    )
    private lazy var logoutUseCase: LogoutUseCase = LogoutUseCase(
        repository: authRepository
    )
    private lazy var createPostUseCase: CreatePostUseCase = CreatePostUseCase(
        repository: postRepository
    )
    private lazy var fetchPostsUseCase: FetchPostsUseCase = FetchPostsUseCase(
        repository: postRepository
    )
    
    // MARK: - ViewModels (Factories)
    // factory methods for VM , bec > a new instance should be created every time a View is created
    func makeSignUpViewModel() -> SignUpViewModel {
        return SignUpViewModel(signUpUseCase: signUpUseCase)
    }
    
    func makeLoginViewModel() -> LoginViewModel {
        return LoginViewModel(loginUseCase: loginUseCase)
    }
    
    func makeMainAppViewModel() -> MainAppViewModel {
        return MainAppViewModel(logoutUseCase: logoutUseCase)
    }
    
    func makeAuthViewModel() -> AuthViewModel {
        return AuthViewModel(authRepository: authRepository)
    }
    
    func makeCreatePostViewModel(authorUID: String) -> CreatePostViewModel {
        return CreatePostViewModel(
            authorUID: authorUID,
            createPostUseCase: createPostUseCase
        )
    }
    
    func makeFeedViewModel() -> FeedViewModel {
        return FeedViewModel(fetchPostsUseCase: fetchPostsUseCase)
    }
}
