//
//  InboxView.swift
//  ChatApp
//
//  Created by Jason Ngo on 22/05/2024.
//

import SwiftUI

struct InboxView: View {
    
    @StateObject private var viewModel = InboxViewModel()
    
    // from root view
    @EnvironmentObject private var router: BaseRouter
    
    @State private var isPresentNewMessage = false

    private var user: User? {
        return viewModel.currentUser
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            List {
                ForEach(viewModel.latestMessages) { message in
                    Button{
                        if let user = message.user {
                            router.navigateTo(InboxRouter.Route.chat(user))
                        }
                    } label: {
                        InboxRowView(message: message)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.visible, for: .tabBar)
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Text("WhatsApp")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.blue)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 24) {
                        Image(systemName: "camera")
                        Image(systemName: "magnifyingglass")
                    }
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.blue)
                }
            }
            Button {
                self.isPresentNewMessage.toggle()
            } label: {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.darkGray))
                    .frame(width: 50, height: 50)
                    .padding()
                    .overlay {
                        Image(systemName: "plus.bubble.fill")
                            .foregroundStyle(.white)
                    }
            }
        }
        .fullScreenCover(isPresented: $isPresentNewMessage) {
            NewMessageView { user in
                self.router.navigateTo(InboxRouter.Route.chat(user))
            }
        }
    }
}

#Preview {
    InboxView()
}

extension View {
    func navigationBarColor(_ backgroundColor: Color) -> some View {
        self.modifier(NavigationBarColorModifier(backgroundColor: backgroundColor))
    }
}

struct NavigationBarColorModifier: ViewModifier {
    var backgroundColor: Color
    
    init(backgroundColor: Color) {
        self.backgroundColor = backgroundColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = UIColor(backgroundColor)
        //UINavigationBar.appearance().standardAppearance = coloredAppearance
        //UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }
    
    func body(content: Content) -> some View {
        content
            .background(backgroundColor)
    }
}
