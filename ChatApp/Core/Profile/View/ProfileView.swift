//
//  ProfileView.swift
//  ChatApp
//
//  Created by Jason Ngo on 22/05/2024.
//

import SwiftUI

struct ProfileView: View {

    var user: User? = UserService.shared.currentUser

    var body: some View {
        NavigationView {
            VStack{
                Spacer()
                NavigationLink {
                    ProfileUpdateInfoScreen()
                } label: {
                    Text("Edit Profile")
                }
                Spacer()
                Button("Logout") {
                    AuthService.shared.signout()
                }
            }
        }.navigationTitle("Settings")
        .navigationBarColor(.white)
    }
}

#Preview {
    ProfileView(user: User.MOCK_USER)
}
