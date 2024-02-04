//
//  UserModel.swift
//  TikTokDigitalWalletFrontEnd
//
//  Created by Marcus Ong on 8/9/23.
//

import Foundation

struct User: Codable {
    
    var uuid: String
    var username: String
    var firstName: String
    var lastName: String
    var email: String
    var password: String
    var signUpDate = Date.now
    var keywordsForLookup: [String] {
        [self.username.generateStringSequence(), self.firstName.generateStringSequence(), self.lastName.generateStringSequence()].flatMap { $0 }
    }
    
    init(uuid: String? = nil, username: String? = nil, firstName: String? = nil, lastName: String? = nil, email: String? = nil, password: String? = nil) {
        self.uuid = uuid ?? ""
        self.username = username ?? ""
        self.firstName = firstName ?? ""
        self.lastName = lastName ?? ""
        self.email = email ?? ""
        self.password = password ?? ""
    }
}

extension String {
    func generateStringSequence() -> [String] {
        /// E.g ) 'Mark' => ['M','Ma',Mar','Mark']
        guard self.count > 0 else {return []}
        var sequences: [String] = []
        
        for i in 1...self.count {
            sequences.append(String(self.prefix(i)))
        }
        return sequences
    }
}
