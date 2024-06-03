//
//  User.swift
//  ChatApp
//
//  Created by Jason Ngo on 20/05/2024.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable,Identifiable,Hashable {
    
    @DocumentID var uid: String?
    var id: String {
        return uid ?? UUID().uuidString
    }
    let fullName: String
    let phoneNumber: String
    var profileImageUrl: String?
    var about: String?
    
    var firstName: String {
        let formatter = PersonNameComponentsFormatter()
        let components = formatter.personNameComponents(from: fullName)
        return components?.givenName ?? fullName
    }
}

extension User {
    
    static let MOCK_USER = User(fullName: "Jason Ngo",phoneNumber: "+1111111", profileImageUrl: "")
    
}
