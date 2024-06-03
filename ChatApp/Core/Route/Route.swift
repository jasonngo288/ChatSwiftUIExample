//
//  Route.swift
//  ChatApp
//
//  Created by Jason Ngo on 22/05/2024.
//

import Foundation

enum Route: Hashable {
    
    case profile(User)
    case ChatView(User)
    
}


enum CommunityRoute: Hashable {
    
    case add
    
}

