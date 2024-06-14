//
//  AddNewCookingRecipeView.swift
//  ChatApp
//
//  Created by Jason Ngo on 30/05/2024.
//

import SwiftUI

struct AddNewCookingRecipeView: View {
    @StateObject var viewModel = AddNewCookingRecipeViewModel()
    @EnvironmentObject var router: BaseRouter
    
    var mCookingRecipe: CookingRecipe? = nil

    private var isEditMode: Bool {
        return mCookingRecipe != nil
    }
    var body: some View {
        LoadingIndicator(isShowing: .constant(viewModel.fetchState == .isLoading)) {
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
                    IngredientRowView(viewModel: viewModel, isEditMode: self.isEditMode)
                }
                Section("INSTRUCTION") {
                    InstructionRowView(viewModel: viewModel, isEditMode: self.isEditMode)
                }
                Section("REFERENCE") {
                    VStack(alignment: .leading, spacing: 0){
                        TextField("Input here", text: $viewModel.refUrl, axis: .vertical)
                            .font(.body)
                    }
                }
                Section(footer: VStack{
                    Button {
                        viewModel.delete()
                    } label: {
                        Text("Delete")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.red)
                    }.frame(alignment: .center)
                }) {
                    EmptyView()
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle(isEditMode ? "Edit" : "Add new")
            .onReceive(viewModel.$isGoBack) { isGoBack in
                if isGoBack {
                    router.navigateBack()
                }
            }
            .onReceive(viewModel.$isGoBackToRoot) { isGoBack in
                if isGoBack {
                    router.popToRoot()
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
            .onAppear {
                if let menu = mCookingRecipe {
                    self.viewModel.setCookingRecipe(menu)
                }
            }.alert("Edit \(viewModel.presentEdit == .Ingredient ? "Ingredient" : "Instruction")", isPresented: .constant(viewModel.presentEdit != DATA_TYPE.none)) {
                TextField("", text: $viewModel.itemEditInput, axis: .vertical)
                Button("OK") {
                    viewModel.editUpdate()
                }
                Button("Cancel", role: .cancel) {
                    viewModel.closeEdit()
                }
            }
            
        }.toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    AddNewCookingRecipeView()
}
