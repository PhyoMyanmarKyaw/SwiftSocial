//
//  MainAppViewModel.swift
//  SwiftSocial
//
//  Created by Phyo Myanmar Kyaw on 10/27/25.
//

import Foundation
import Combine

@MainActor
class MainAppViewModel: ObservableObject {
    private let logoutUseCase: LogoutUseCase
    
    init(logoutUseCase: LogoutUseCase) {
        self.logoutUseCase = logoutUseCase
    }
    
    func logout() async {
        _ = await logoutUseCase.execute()
    }
}

