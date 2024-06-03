//
//  Country.swift
//  ChatApp
//
//  Created by Jason Ngo on 21/05/2024.
//

import Foundation

struct Country: Codable,Identifiable,Hashable {
    
    let id = UUID()  // <--- here
    let name: String
    let code: String
    let dia: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case code
        case dia
    }
}
