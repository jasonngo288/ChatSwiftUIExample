//
//  MainTabbarView.swift
//  ChatApp
//
//  Created by Jason Ngo on 21/05/2024.
//

import SwiftUI

struct MainTabbarView: View {
    @State private var selectedTab: Int = 0
    var body: some View {
        TabView {
            InboxRouterView()
                .tabItem {
                    VStack {
                        Image(systemName: "text.bubble.fill")
                            .environment(\.symbolVariants,selectedTab == 0 ? .fill : .none)
                        Text("Chats")
                    }
                }
                .onAppear{
                    selectedTab = 0
                }
            Text("Calls")
                .tabItem {
                    VStack {
                        Image(systemName: "phone")
                            .environment(\.symbolVariants,selectedTab == 1 ? .fill : .none)
                        Text("Calls")
                    }
                }
                .onAppear{
                    selectedTab = 1
                }
            CommunityRouterView()
            .tabItem {
                VStack {
                    Image(systemName: "person.3")
                        .environment(\.symbolVariants,selectedTab == 2 ? .fill : .none)
                    Text("Communities")
                }
            }
            .onAppear{
                selectedTab = 2
            }
            UpdatesRouterView()
                .tabItem {
                    VStack {
                        Image(systemName: "dial.low")
                            .environment(\.symbolVariants,selectedTab == 3 ? .fill : .none)
                        Text("Updates")
                    }
                }
                .onAppear{
                    selectedTab = 3
                }
            
            ProfileView()
                .tabItem {
                    VStack {
                        Image(systemName: "gear")
                            .environment(\.symbolVariants,selectedTab == 4 ? .fill : .none)
                        Text("settings")
                    }
                }
                .onAppear{
                    selectedTab = 4
                }
        }
        .tint(.blue)
    }
}

#Preview {
    MainTabbarView()
}
