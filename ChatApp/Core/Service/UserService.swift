//
//  UserService.swift
//  ChatApp
//
//  Created by Jason Ngo on 20/05/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseFirestore

class UserService {
    
    @Published var currentUser: User?
    
    static let shared = UserService()
    
    @MainActor
    func fetchCurrentUser(completion: (() -> Void)? = nil) async throws {
        print("fetchCurrentUser")
        guard let uid = Auth.auth().currentUser?.uid else {
            completion?()
            return
        }
        do{
            let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
            let user = try snapshot.data(as: User.self)
            self.currentUser = user
            completion?()
        } catch {
            print("fail fetch current user: \(error.localizedDescription)")
            completion?()
        }
    }
    
    static func fetchAllUsers(limit: Int? = nil) async throws -> [User] {
        let query = FirestoreConstants.userCollection
        if let limit { query.limit(to: limit) }
        let snapshot = try await query.getDocuments()
        let users = snapshot.documents.compactMap({ try? $0.data(as: User.self)})
        return users
    }
    
    static func fetchUser(withUid uid: String, completion: @escaping(User?) -> Void) {
        FirestoreConstants.userCollection.document(uid).getDocument { snapshot, _ in
            let user = try? snapshot?.data(as: User.self)
            completion(user)
        }
    }
    
    static func fetchUser(withPhone phoneNumber: String, completion: @escaping(User?) -> Void) {
        FirestoreConstants.userCollection.whereField("phoneNumber", isEqualTo: phoneNumber).getDocuments { snapshot, _ in
            let user = try? snapshot?.documents.first?.data(as: User.self)
            completion(user)
        }
    }
    
    @MainActor
    func updateUserProfileImage(withImageUrl imageUrl: String) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        try await Firestore.firestore().collection("users").document(currentUid).updateData([
            "profileImageUrl": imageUrl
        ])
        self.currentUser?.profileImageUrl = imageUrl
    }
    
}
