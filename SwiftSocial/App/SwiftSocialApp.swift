//
//  SwiftSocialApp.swift
//  SwiftSocial
//
//  Created by Phyo Myanmar Kyaw on 10/27/25.
//

import SwiftUI
import FirebaseCore

@main
struct SwiftSocialApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    private let diContainer: DIContainer
    
    @StateObject private var authViewModel: AuthViewModel
    
    init() {
        // single container
        let container = DIContainer()
        self.diContainer = container
        _authViewModel = StateObject(
            wrappedValue: container.makeAuthViewModel()
        )
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(diContainer: diContainer, authViewModel: authViewModel)
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // plist name from the .xcconfig file
#if DEBUG
        let plistName = "GoogleService-Info-Dev"
#else
        let plistName = "GoogleService-Info-Prod"
#endif
        
        guard let plistPath = Bundle.main.path(forResource: plistName, ofType: "plist") else {
            fatalError("Couldn't find \(plistName).plist file. Make sure it's included in the app bundle.")
        }
        
        guard let options = FirebaseOptions(contentsOfFile: plistPath) else {
            fatalError("Couldn't load Firebase options from \(plistName).plist file.")
        }
        
        FirebaseApp.configure(options: options)
        print("Firebase configured successfully with: \(plistName).plist")
        
        return true
    }
}
