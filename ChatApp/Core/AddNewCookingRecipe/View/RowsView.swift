//
//  IngredientRowView.swift
//  ChatApp
//
//  Created by Jason Ngo on 31/05/2024.
//

import SwiftUI

struct IngredientRowView: View {
    @StateObject var viewModel: AddNewCookingRecipeViewModel
    var isEditMode: Bool = false
    var body: some View {
        RowItemView(data: $viewModel.ingredients, input: $viewModel.ingredientInput, isEditMode: self.isEditMode) {
            viewModel.addNewIngredient()
        } onRemove: { item in
            viewModel.removeIngredient(item: item)
        } onEdit: { index in
            viewModel.setPresentEdit(type: .Ingredient, index: index)
        }
    }
}


struct InstructionRowView: View {
    @StateObject var viewModel: AddNewCookingRecipeViewModel
    var isEditMode: Bool = false
    var body: some View {
        RowItemView(data: $viewModel.instructions, input: $viewModel.instructionInput, isEditMode: self.isEditMode) {
            viewModel.addNewInstruction()
        } onRemove: { item in
            viewModel.removeInstruction(item: item)
        } onEdit: { index in
            viewModel.setPresentEdit(type: .Instruction, index: index)
        }

    }
}

struct RowItemView: View {
    @Binding var data: [String]
    @Binding var input: String
    
    var isEditMode: Bool = false
    var onAdd:()->Void
    var onRemove:(String)->Void
    var onEdit:((Int)->Void)?
    
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
            ForEach(0..<data.count, id: \.self) { index in
                VStack{
                    HStack(spacing: 0){
                        Text(data[index])
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        if isEditMode {
                            Button {
                                onEdit?(index)
                            } label: {
                                Image(systemName: "square.and.pencil")
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            .frame(width: 30, height: 40, alignment: .trailing)
                        }
                        Button {
                            onRemove(data[index])
                        } label: {
                            Image(systemName: "xmark.circle")
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        .frame(width: 30, height: 40, alignment: .trailing)
                    }
                    Divider()
                }
            }
        }
    }
}
