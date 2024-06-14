//
//  UpdatesRouterView.swift
//  ChatApp
//
//  Created by Jason Ngo on 14/06/2024.
//

import SwiftUI

struct UpdatesRouterView: View {
    @StateObject var router = BaseRouter()

    var body: some View {
        NavigationStack(path: $router.paths) {
                UpdatesView()
                .navigationDestination(for: UpdatesRouter.Route.self) { route in
                    UpdatesRouter.view(for: route)
                }
        }
        .environmentObject(router)
    }
}

struct UpdatesRouter {
    enum Route: Hashable {
        case new
        case detail
        case edit
    }
    
    @ViewBuilder static func view(for rout: Route) -> some View {
        EmptyView()
    }
}

#Preview {
    UpdatesRouterView()
}
