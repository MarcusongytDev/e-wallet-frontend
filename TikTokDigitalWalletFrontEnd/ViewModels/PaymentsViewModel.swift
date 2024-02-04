//
//  PaymentsViewModel.swift
//  TikTokDigitalWalletFrontEnd
//
//  Created by Marcus Ong on 7/9/23.
//

import Foundation
import SwiftUI

class PaymentsViewModel: ObservableObject {
    
    func SendTransactionData(senderId: String, receiverId: String, amount: String) {
        
        let url = URL(string: "https://ewallet2.fly.dev/pay")!
        
        var request = URLRequest(url: url)
        
        print("Sending TransactionData")
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: String] = [
            "senderId"      : senderId,
            "receiverId"    : receiverId,
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
    
    func showTransactions(userId: String, dateFilter: String) {
        
        let url = URL(string: "https://ewallet2.fly.dev/showTransactions")!
        
        var request = URLRequest(url: url)
        
        print("Getting user's past transaction data")
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: String] = [
            "userId"    : userId,
            "dateFiler" : dateFilter
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
