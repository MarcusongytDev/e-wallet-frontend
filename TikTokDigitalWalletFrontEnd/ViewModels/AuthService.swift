//
//  AuthService.swift
//  TikTokDigitalWalletFrontEnd
//
//  Created by Marcus Ong on 9/9/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

enum AuthState {
    case undefined
    case authenticated
    case notAuthenticated
}

class AuthService: ObservableObject {
    @Published var user = User()
    @Published var authState: AuthState = .undefined
    @Published var uid: String = ""
    
    init() {
        setupAuthListener()
    }
    
    func setupAuthListener() {
        Auth.auth().addStateDidChangeListener { _, user in
            self.authState = user == nil ? .notAuthenticated : .authenticated
            guard let user = user else { return }
            self.uid = user.uid
        }
    }
    
    func signUp(_ email: String, password: String, username: String, firstName: String, lastName: String) async throws {
//        guard name != "" else { return }
        try await Auth.auth().createUser(withEmail: email, password: password)
        guard uid != "" else { return }
        try createProfile(email: email, password: password, username: username, firstName: firstName, lastName: lastName)
    }
    
    func createProfile(email: String, password: String, username: String, firstName: String, lastName: String) throws {
        let reference = Firestore.firestore().collection("users").document(uid)
        let user = User(uuid: Auth.auth().currentUser?.uid ,username: username, firstName: firstName, lastName: lastName, email: email, password: password)
        try reference.setData(from: user)
        reference.updateData(["keywordsForLookup": user.keywordsForLookup])
    }
    
    func login(_ email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func logout() throws {
        try Auth.auth().signOut()
    }
    
    func fetchUser() async throws {
//        guard uid != "" else { return }
        let reference = Firestore.firestore().collection("users").document(uid)
        user = try await reference.getDocument(as: User.self)
    }
}
