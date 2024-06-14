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
        let snapshot = try await query.getDocuments()
        print("Cookings has \(snapshot.documents.count) values")
        let dataList = snapshot.documents.compactMap({ try? $0.data(as: CookingRecipe.self)})
        return dataList
    }
    
    func fetchMenuDetail(with id: String) async throws -> CookingRecipe? {
        let snapshot = try await FirestoreConstants.cookingCollection.document(id).getDocument()
        print("Cookings has value:", snapshot.data() as Any)
        return try? snapshot.data(as: CookingRecipe.self)
    }
    
    func deleteMenu(with id: String, completed: (@escaping(String?)->Void)) {
        FirestoreConstants.cookingCollection.document(id).delete { error in
            if let err = error {
                completed(err.localizedDescription)
            } else {
                completed(nil)
            }
        }
    }
    
    
    func addMenu(withMenu menu: CookingRecipe, completed: (@escaping(String?)->Void)) {
        let cookingCollectionRef = FirestoreConstants.cookingCollection.document()
        var newMenu = menu
        if menu.uid == nil {
            let docID = cookingCollectionRef.documentID
            newMenu.uid = docID
        }
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
    
    func updateMenu(withId uid: String, menu: CookingRecipe, completed: (@escaping(String?)->Void)) {
        let cookingCollectionRef = FirestoreConstants.cookingCollection.document(uid)
        guard let newData = try? Firestore.Encoder().encode(menu) else {
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
