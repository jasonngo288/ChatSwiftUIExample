//
//  IngredientRowView.swift
//  ChatApp
//
//  Created by Jason Ngo on 31/05/2024.
//

import SwiftUI

struct IngredientRowView: View {
    
    @StateObject var viewModel: AddNewCookingRecipeViewModel
    var body: some View {
        RowItemView(data: $viewModel.ingredients, input: $viewModel.ingredientInput) {
            viewModel.addNewIngredient()
        } onRemove: { item in
            viewModel.removeIngredient(item: item)
        }
    }
}


struct InstructionRowView: View {
    
    @StateObject var viewModel: AddNewCookingRecipeViewModel
    var body: some View {
        RowItemView(data: $viewModel.instructions, input: $viewModel.instructionInput) {
            viewModel.addNewInstruction()
        } onRemove: { item in
            viewModel.removeInstruction(item: item)
        }

    }
}

struct RowItemView: View {
    @Binding var data: [String]
    @Binding var input: String
    
    var onAdd:()->Void
    var onRemove:(String)->Void
    
    var body: some View {
        VStack{
            HStack(spacing: 0) {
                TextField("Input here", text: $input, axis: .vertical)
                    .font(.body)
                Button("Add") {
                    onAdd()
                }
                .buttonStyle(BorderlessButtonStyle())
                .frame(width: 40, height: 40, alignment: .trailing)
            }
            Divider()
            ForEach(data, id: \.self) { item in
                VStack{
                    HStack(spacing: 0){
                        Text(item)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        Button {
                            onRemove(item)
                        } label: {
                            Image(systemName: "xmark")
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        .frame(width: 40, height: 40, alignment: .trailing)
                    }
                    Divider()
                }
            }
        }
    }
}
