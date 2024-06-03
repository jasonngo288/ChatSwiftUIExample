//
//  Constants.swift
//  ChatApp
//
//  Created by Jason Ngo on 20/05/2024.
//

import Foundation
import FirebaseFirestore

struct FirestoreConstants {
    
    static let userCollection = Firestore.firestore().collection("users")
    static let messageCollection = Firestore.firestore().collection("messages")
    static let cookingCollection = Firestore.firestore().collection("cookings")
}


struct Regex {
    public static let serverFormat = #"<format>(.*?)<\/format>"#
}
