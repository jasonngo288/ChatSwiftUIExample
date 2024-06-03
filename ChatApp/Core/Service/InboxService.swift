//
//  InboxService.swift
//  ChatApp
//
//  Created by Jason Ngo on 22/05/2024.
//

import Foundation
import Firebase
import FirebaseFirestore

class InboxService {
    
    @Published var documentChanges: [DocumentChange] = []
    
    func observeLatestMessages() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let query = FirestoreConstants.messageCollection.document(uid).collection("latest-messages").order(by: "timestamp", descending: true)
        query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter({
                $0.type == .added || $0.type == .modified
            }) else { return }
            self.documentChanges = changes
        }
    }
    
}
