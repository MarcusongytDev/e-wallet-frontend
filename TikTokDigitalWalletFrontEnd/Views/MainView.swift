//
//  MainView.swift
//  TikTokDigitalWalletFrontEnd
//
//  Created by Marcus Ong on 9/9/23.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject private var authService: AuthService
    
    var body: some View {
        switch authService.authState {
        case .undefined:
            ProgressView()
        case .notAuthenticated:
            AuthenticationView()
        case .authenticated:
            ApplicationTabView()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(AuthService())
    }
}
