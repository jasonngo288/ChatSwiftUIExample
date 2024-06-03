//
//  CookingRecipe.swift
//  ChatApp
//
//  Created by Jason Ngo on 29/05/2024.
//

import Foundation
import FirebaseFirestoreSwift

struct CookingRecipe: Codable,Identifiable,Hashable {
    @DocumentID var uid: String?
    var id: String {
        return uid ?? UUID().uuidString
    }
    let title: String
    let photoUrl: String
    let ingredients: [String]
    let instructions: [String]
}

extension CookingRecipe {
    
    static let MOKUP = CookingRecipe(title: "", photoUrl: "", ingredients: [], instructions: [])
}
