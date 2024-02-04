//
//  AuthenticationViewModel.swift
//  TikTokDigitalWalletFrontEnd
//
//  Created by Marcus Ong on 9/9/23.
//

import Foundation
import SwiftUI

class AuthenticationViewModel: ObservableObject {
    
    
    func SendAddWalletData(userId: String) {
        
        let url = URL(string: "https://ewallet2.fly.dev/add-wallet")!
        
        var request = URLRequest(url: url)
        
        print("Sending AddWalletData")
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: String] = [
            "userId" : userId,
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let response = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print("SUCCESS: \(response)")
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    
}
