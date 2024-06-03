//
//  NewMessageViewModel.swift
//  ChatApp
//
//  Created by Jason Ngo on 24/05/2024.
//

import Foundation
import FirebaseAuth

class NewMessageViewModel: ObservableObject {
    
    @Published var users = [User]()
    
    init() {
        Task { try await fetchUsers() }
    }
    
    func fetchUsers() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let users = try await UserService.fetchAllUsers()
        self.users = users.filter({ $0.id != uid })
    }
}
