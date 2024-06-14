//
//  InboxRouterView.swift
//  ChatApp
//
//  Created by Jason Ngo on 12/06/2024.
//

import SwiftUI

struct InboxRouterView: View {
    
    @StateObject var router = BaseRouter()

    var body: some View {
        NavigationStack(path: $router.paths) {
            InboxView()
                .navigationDestination(for: InboxRouter.Route.self) { route in
                    InboxRouter.view(for: route, router: router)
                }
            
        }
        .environmentObject(router)
    }
}

struct InboxRouter {
    
    // Contains the possible destinations in our Router
    enum Route: Hashable {
        case chat(User)
        case profile
    }
    
    // Builds the views
    @ViewBuilder static func view(for route: Route, router: BaseRouter) -> some View {
        switch route {
        case .chat(let user):
            ChatView(user: user)
        case .profile:
            ProfileView()
        }
    }
}
