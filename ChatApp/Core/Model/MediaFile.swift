//
//  MediaFile.swift
//  ChatApp
//
//  Created by Jason Ngo on 23/05/2024.
//

import Foundation
import FirebaseFirestoreSwift

struct MediaFile: Codable,Identifiable,Hashable {
    @DocumentID var uid: String?
    var id: String {
        return uid ?? UUID().uuidString
    }
    var mediaData: String?
    var mediaType: String?
}
