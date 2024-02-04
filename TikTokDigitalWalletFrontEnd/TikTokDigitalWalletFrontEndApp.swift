//
//  TikTokDigitalWalletFrontEndApp.swift
//  TikTokDigitalWalletFrontEnd
//
//  Created by Marcus Ong on 6/9/23.
//

import SwiftUI
import Firebase
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct TikTokDigitalWalletFrontEndApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject private var authService = AuthService()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(authService)
        }
    }
}
