//
//  CookingService.swift
//  ChatApp
//
//  Created by Jason Ngo on 30/05/2024.
//

import Foundation
import Firebase
import FirebaseFirestore

class CookingService {
    
    static let shared = CookingService()

    func fetchMenuList(withLimit limit: Int? = nil) async throws -> [CookingRecipe] {
        let query = FirestoreConstants.cookingCollection
        if let limit { query.limit(to: limit) }
        if let limit { query.limit(to: limit) }
        let snapshot = try await query.getDocuments()
        print(snapshot)
        let dataList = snapshot.documents.compactMap({ try? $0.data(as: CookingRecipe.self)})
        return dataList
    }
    
    func addMenu(withMenu menu: CookingRecipe, completed: (@escaping(String?)->Void)) {
        let cookingCollectionRef = FirestoreConstants.cookingCollection.document()
        let docID = cookingCollectionRef.documentID
        var newMenu = menu
        newMenu.uid = docID

        guard let newData = try? Firestore.Encoder().encode(newMenu) else {
            completed("addMenu: encode fail")
            return
        }
        cookingCollectionRef.setData(newData) { error in
            if let err = error {
                completed(err.localizedDescription)
            } else {
                completed(nil)
            }
        }
    }
}
