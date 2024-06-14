//
//  CommunityView.swift
//  ChatApp
//
//  Created by Jason Ngo on 29/05/2024.
//

import SwiftUI
import Kingfisher

struct CommunityView: View {
    @StateObject var viewModel = CommunityViewModel()
    @EnvironmentObject var router: BaseRouter
    
    var body: some View {
        VStack{
            List{
                ForEach(viewModel.listItem) {item in
                    Button {
                        router.navigateTo(CommunityRouter.Route.detail(item))
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
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 24) {
                        Button {
                            router.navigateTo(CommunityRouter.Route.new)
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

#Preview {
    CommunityView()
}
