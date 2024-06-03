//
//  UploadFileService.swift
//  ChatApp
//
//  Created by Jason Ngo on 23/05/2024.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class UploadFileService {
    
    static let shared = UploadFileService()
    
    init() {}
    
    func uploadImage(withImage file: UIImage, imageName: String, completed: @escaping(String?)->Void) {
        guard let imageData = file.convert(toSize: CGSizeMake(100, 100), scale: 1).jpegData(compressionQuality: 1) else {
            completed(nil)
            return
        }
        
        let mediaFile = MediaFile(uid: UUID().uuidString, mediaData: imageData.base64EncodedString(), mediaType: "image")
        guard let encodedData = try? Firestore.Encoder().encode(mediaFile) else {
            completed(nil)
            print("MediaFile encode failed")
            return
        }
        Firestore.firestore().collection("images").document(mediaFile.id).setData(encodedData) { (error) in
            if let _err = error {
                completed(nil)
                print("save MediaFile: \(_err.localizedDescription)")
            } else {
                completed(mediaFile.id)
                print("save MediaFile: \(mediaFile.id)")

            }
        }
    }
    
    func fetchImage(withID id: String?, completion: ((MediaFile?) -> Void)? = nil) async {
        print("fetchImage: \(id ?? "")")
        guard let uid = id, !uid.isEmpty else {
            completion?(nil)
            return
        }
        do{
            let snapshot = try await Firestore.firestore().collection("images").document(uid).getDocument()
            let data = try snapshot.data(as: MediaFile.self)
            completion?(data)
        } catch {
            print("fail fetch current user: \(error.localizedDescription)")
            completion?(nil)
        }
    }
}
