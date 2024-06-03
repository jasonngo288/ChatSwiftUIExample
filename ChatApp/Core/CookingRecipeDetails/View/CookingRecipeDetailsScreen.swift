//
//  CookingRecipeDetailsScreen.swift
//  ChatApp
//
//  Created by Jason Ngo on 30/05/2024.
//

import SwiftUI
import Kingfisher

struct CookingRecipeDetailsScreen: View {
    
    let cookingRecipe: CookingRecipe
    
    @StateObject private var viewModel = CookingRecipeDetailsViewModel()
    
    private let mainScreenSize = UIScreen.main.bounds
    
    var body: some View {
        NavigationStack{
            VStack{
                List{
                    Section(header: VStack{
                        KFImage(URL(string: cookingRecipe.photoUrl )!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: mainScreenSize.width - 20)
                        Text(cookingRecipe.title)
                            .font(.title)
                            .foregroundColor(Color.black)
                            .padding(.top, 12)
                    }) {
                        EmptyView()
                    }
                    Section("Nguyên Liệu".uppercased()) {
                        VStack{
                            ForEach(cookingRecipe.ingredients, id: \.self) { item in
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
                            ForEach(0..<cookingRecipe.instructions.count, id: \.self) { index in
                                VStack{
                                    HStack{
                                        Text(transformAttribute(textFormat: "\(index+1). ", appendText: cookingRecipe.instructions[index]))
                                    }
                                    Divider()
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Details")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 24) {
                        Image(systemName: "square.and.arrow.up")
                    }
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.blue)
                }
            }
            
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
    CookingRecipeDetailsScreen(cookingRecipe: CookingRecipe.MOKUP)
}
