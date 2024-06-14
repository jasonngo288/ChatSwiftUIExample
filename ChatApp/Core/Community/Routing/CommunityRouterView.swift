//
//  CommunityRouter.swift
//  ChatApp
//
//  Created by Jason Ngo on 07/06/2024.
//

import Foundation
import SwiftUI

// View containing the necessary SwiftUI
// code to utilize a NavigationStack for
// navigation accross our views.
struct CommunityRouterView: View {
    @StateObject var router = BaseRouter()

    var body: some View {
        NavigationStack(path: $router.paths) {
                CommunityView()
                .navigationDestination(for: CommunityRouter.Route.self) { route in
                    CommunityRouter.view(for: route)
                }
        }
        .environmentObject(router)
    }
}

struct CommunityRouter {
    
    // Contains the possible destinations in our Router
    enum Route: Hashable {
        case list
        case detail(CookingRecipe)
        case new
        case edit(CookingRecipe)
    }
    
    // Builds the views
    @ViewBuilder static func view(for route: Route) -> some View {
        switch route {
        case .list:
            CommunityView()
        case .detail(let data):
            CookingRecipeDetailsView(cookingRecipe: data)
        case .edit(let data):
            AddNewCookingRecipeView(mCookingRecipe: data)
        case .new:
            AddNewCookingRecipeView()
        }
    }
}
