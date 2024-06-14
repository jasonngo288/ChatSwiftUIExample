//
//  NewMessageView.swift
//  ChatApp
//
//  Created by Jason Ngo on 22/05/2024.
//

import SwiftUI

import Kingfisher

struct NewMessageView: View {
    
    @State private var searchText = ""
    @StateObject private var viewModel = NewMessageViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var onSelectedUser: (User)->Void
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(alignment: .leading,spacing: 24) {
                    HStack(spacing: 16) {
                        Image(systemName: "person.2.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(.gray)
                        Text("New group")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    HStack(spacing: 16) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(.gray)
                        Text("New contact")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    HStack(spacing: 16) {
                        Image(systemName: "shared.with.you.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(.gray)
                        Text("New community")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                }
                .padding(.top)
                .padding(.horizontal)
                Text("Contacts on WhatsApp")
                    .foregroundStyle(Color(.darkGray))
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                ForEach (viewModel.users) { user in
                    VStack {
                        HStack {
                            ZStack {
                                CircularProfileImageView(imageId: user.profileImageUrl , size: .small)
                            }
                            VStack(alignment: .leading) {
                                Text(user.fullName)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                Text("Hey there! I am using WhatsApp.")
                                    .font(.footnote)
                                    .foregroundStyle(.gray)
                            }
                            
                            Spacer()
                        }
                        .padding(.leading)
                    }
                    .padding(.bottom,20)
                    .onTapGesture {
                        dismiss()
                        onSelectedUser(user)
                    }
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        HStack(spacing: 16) {
                            Image(systemName: "chevron.backward")
                            VStack(alignment: .leading) {
                                Text("Select contact")
                                    .font(.subheadline)
                                Text("\(viewModel.users.count) contacts")
                                    .font(.caption2)
                            }.foregroundStyle(.black)
                        }.foregroundStyle(.blue)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 24) {
                        Image(systemName: "magnifyingglass")
                        Image(systemName: "ellipsis")
                    }
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.blue)
                }
            }
        }
    }
}


#Preview {
    NewMessageView{ _ in
        
    }
}
