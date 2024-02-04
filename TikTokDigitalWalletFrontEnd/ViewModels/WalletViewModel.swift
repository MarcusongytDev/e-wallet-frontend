//
//  WalletViewModel.swift
//  TikTokDigitalWalletFrontEnd
//
//  Created by Marcus Ong on 7/9/23.
//

import Foundation
import SwiftUI

class WalletViewModel: ObservableObject {
    
    
    func SendTopUpWalletData(userId: String, accNum: String, amount: String) {
        
        //top up wallet func url
        let url = URL(string: "http:/localhost:3000/add-wallet")!
        
        var request = URLRequest(url: url)
        
        print("Sending TopUpWalletData")
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: String] = [
            "userId"        : userId,
            "accNum"        : accNum,
            "amount"        : amount
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
    
    func SendWithdrawFromWalletData(userId: String, accNum: String, amount: String) {
        
        //withdraw_from_wallet func url
        let url = URL(string: "http:/localhost:3000/add-wallet")!
        
        var request = URLRequest(url: url)
        
        print("Sending WithdrawFromWalletData")
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: String] = [
            "userId"        : userId,
            "accNum"        : accNum,
            "amount"        : amount
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
