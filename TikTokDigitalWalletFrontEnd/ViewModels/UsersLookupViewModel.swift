//
//  UsersLookupViewModel.swift
//  TikTokDigitalWalletFrontEnd
//
//  Created by Marcus Ong on 9/9/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class UsersLookupViewModel: ObservableObject {
    @Published var queriedUsers: [User] = []
    
    private let db = Firestore.firestore()
    
    func fetchUsers(from keyword: String) {
        db.collection("users").whereField("keywordsForLookup", arrayContains: keyword).getDocuments { QuerySnapshot, error in
            guard let documents = QuerySnapshot?.documents, error == nil else { return }
            self.queriedUsers = documents.compactMap { QueryDocumentSnapshot in
                try? QueryDocumentSnapshot.data(as: User.self)
            }
        }
    }
}
