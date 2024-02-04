//
//  ApplicationTabView.swift
//  TikTokDigitalWalletFrontEnd
//
//  Created by Marcus Ong on 8/9/23.
//

import SwiftUI

struct ApplicationTabView: View {
    
    var body: some View {
        TabView {
            WalletView()
                .tabItem {
                    Image(systemName: "creditcard.fill")
                    Text("Wallet")
                }
            
            PaymentsView()
                .tabItem {
//                    Image(systemName: "dollarsign.circle.fill")
                    Image(systemName: "paperplane.fill")
                    Text("Payments")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }

        }
        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
                            tabBarAppearance.configureWithOpaqueBackground()
                            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
                            // correct the transparency bug for Navigation bars
                            let navigationBarAppearance = UINavigationBarAppearance()
                            navigationBarAppearance.configureWithOpaqueBackground()
                            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        }
        .preferredColorScheme(.dark)
    }
}

struct ApplicationTabView_Previews: PreviewProvider {
    static var previews: some View {
        ApplicationTabView()
    }
}
