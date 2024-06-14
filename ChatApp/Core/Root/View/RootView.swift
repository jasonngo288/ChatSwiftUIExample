//
//  ContentView.swift
//  ChatApp
//
//  Created by Jason Ngo on 20/05/2024.
//

import SwiftUI

struct RootView: View {
    @StateObject private var viewModel = RootViewModel()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                MainTabbarView()
            } else {
                WelcomeView()
            }
        }
        .fullScreenCover(isPresented: $viewModel.isGoToUpdateProfile, onDismiss: {
            viewModel.checkLogic()
        }, content: {
            NavigationView{
                ProfileUpdateInfoView()
            }
        })
        
    }
}

#Preview {
    RootView()
}
