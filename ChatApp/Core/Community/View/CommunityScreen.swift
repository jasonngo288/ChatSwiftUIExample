//
//  CommunityScreen.swift
//  ChatApp
//
//  Created by Jason Ngo on 29/05/2024.
//

import SwiftUI
import Kingfisher

struct CommunityScreen: View {
    @StateObject var viewModel = CommunityViewModel()
    var body: some View {
        NavigationStack{
            VStack{
                List{
                    ForEach(viewModel.listItem) {item in
                        NavigationLink {
                            CookingRecipeDetailsScreen(cookingRecipe: item)
                        } label: {
                            HStack(alignment: .top){
                                KFImage(URL(string: item.photoUrl)!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100, alignment: .center)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .clipped()
                                Text(item.title)
                                    .font(.subheadline)
                                    .frame(alignment: .topLeading)
                            }
                        }
                    }
                }
            }.navigationTitle("Menu")
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar(.visible, for: .tabBar)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 24) {
                        NavigationLink {
                            AddNewCookingRecipeScreen()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.blue)
                }
            }.onAppear {
                Task {
                    await viewModel.fetchData()
                }
            }
        }
    }
}

#Preview {
    CommunityScreen()
}
