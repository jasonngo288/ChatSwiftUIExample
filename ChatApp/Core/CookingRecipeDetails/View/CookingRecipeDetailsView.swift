//
//  CookingRecipeDetailsView.swift
//  ChatApp
//
//  Created by Jason Ngo on 30/05/2024.
//

import SwiftUI
import Kingfisher

struct CookingRecipeDetailsView: View {
    
    var cookingRecipe: CookingRecipe
    @StateObject private var viewModel = CookingRecipeDetailsViewModel()
    
    private let mainScreenSize = UIScreen.main.bounds
    @EnvironmentObject var router: BaseRouter
    
    var body: some View {
        VStack{
            List{
                Section(header: VStack{
                    if let url = URL(string: viewModel.cookingRecipe.photoUrl) {
                        KFImage(url)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: mainScreenSize.width - 20)
                    }
                    Text(viewModel.cookingRecipe.title)
                        .font(.title)
                        .foregroundColor(Color.black)
                        .padding(.top, 12)
                }) {
                    EmptyView()
                }
                Section("Nguyên Liệu".uppercased()) {
                    VStack{
                        ForEach(viewModel.cookingRecipe.ingredients, id: \.self) { item in
                            VStack{
                                Text(item)
                                    .font(.body)
                                    .padding(.vertical, 4)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Divider()
                            }
                        }
                    }
                }
                Section("Hướng dẫn nấu nướng".uppercased()) {
                    VStack{
                        ForEach(0..<viewModel.cookingRecipe.instructions.count, id: \.self) { index in
                            VStack{
                                Text(transformAttribute(textFormat: "\(index+1). ", appendText: viewModel.cookingRecipe.instructions[index]))
                                    .font(.body)
                                    .padding(.vertical, 4)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Divider()
                            }
                        }
                    }
                }
                Section("Nguồn tham khảo".uppercased()) {
                    VStack{
                        Text(viewModel.cookingRecipe.refUrl ?? "N/A")
                            .font(.body)
                            .frame(alignment: .leading)
                    }
                }
            }
        }
        .navigationTitle("Details")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                HStack(spacing: 24) {
                    Button {
                        router.pushTo(CommunityRouter.Route.detail(viewModel.cookingRecipe))
                    } label: {
                        Text("Edit")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.blue)
                            .frame(height: 44)
                    }
                }
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.blue)
            }
        }
        .onAppear {
            self.viewModel.fetchDataDetail(self.cookingRecipe)
        }
    }
    
    private func transformAttribute(textFormat: String, appendText: String) -> AttributedString {
        let attrKey = [NSAttributedString.Key.font]
        let attrValue = [UIFont.boldSystemFont(ofSize: 18)]
        return "<format>\(textFormat)</format>".styleAttributed(
            pattern: Regex.serverFormat,
            keys:attrKey,
            values:attrValue
        ).appendText(appendText).toAttributedString()
    }
}

#Preview {
    CookingRecipeDetailsView(cookingRecipe: CookingRecipe.MOKUP)
}
