//
//  AddNewCookingRecipeScreen.swift
//  ChatApp
//
//  Created by Jason Ngo on 30/05/2024.
//

import SwiftUI

struct AddNewCookingRecipeScreen: View {
    @StateObject var viewModel = AddNewCookingRecipeViewModel()
    @Environment(\.dismiss) var dimiss
    
    var body: some View {
        NavigationStack {
            List{
                Section("TITLE") {
                    VStack(alignment: .leading, spacing: 0){
                        TextField("Input here", text: $viewModel.title, axis: .vertical).font(.body)
                    }
                }
                Section("PHOTO URL") {
                    VStack(alignment: .leading, spacing: 0){
                        TextField("Input here", text: $viewModel.photoUrl, axis: .vertical)
                            .font(.body)
                    }
                }
                Section("INGREDIENTS") {
                    IngredientRowView(viewModel: viewModel)
                }
                Section("INSTRUCTION") {
                    InstructionRowView(viewModel: viewModel)
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Add new")
            .onReceive(viewModel.$isGoBack) { isGoBack in
                if isGoBack {
                    dimiss()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.saveMenu()
                    } label: {
                        Text("Save")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.blue)
                            .frame(height: 44)
                    }
                }
            }
            
        }.toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    AddNewCookingRecipeScreen()
}
