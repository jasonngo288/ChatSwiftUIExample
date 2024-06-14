//
//  AddNewCookingRecipeViewModel.swift
//  ChatApp
//
//  Created by Jason Ngo on 30/05/2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

enum DATA_TYPE: Comparable {
    case Ingredient
    case Instruction
    case none
}

class AddNewCookingRecipeViewModel: ObservableObject {
 
    @Published var title: String = ""
    @Published var photoUrl: String = ""
    @Published var ingredients: [String] = []
    @Published var ingredientInput: String = ""
    @Published var refUrl: String = ""

    @Published var instructions: [String] = []
    @Published var instructionInput: String = ""
    
    @Published var isGoBack: Bool = false
    @Published var isGoBackToRoot: Bool = false
    @Published var messageError: String = ""
    
    @Published var presentEdit: DATA_TYPE = .none
    @Published var itemIndexEdit: Int = -1
    @Published var itemEditInput: String = ""
    
    @Published var fetchState: FetchState = .start

    private var mCookingRecipe: CookingRecipe? = nil
    
    func addNewIngredient() {
        ingredients.append(ingredientInput)
        ingredientInput = ""
    }
    
    func removeIngredient(item: String) {
        ingredients = ingredients.filter{$0 != item}
    }
    
    func addNewInstruction() {
        instructions.append(instructionInput)
        instructionInput = ""
    }
    
    func removeInstruction(item: String) {
        instructions = instructions.filter{$0 != item}
    }
    
    func setPresentEdit(type: DATA_TYPE, index: Int = -1) {
        self.presentEdit = type
        self.itemIndexEdit = index
        switch type {
        case .Ingredient:
            self.itemEditInput = ingredients[index]
        case .Instruction:
            self.itemEditInput = instructions[index]
        case .none:
            self.itemEditInput = ""
        }
    }
    
    func closeEdit() {
        setPresentEdit(type: .none)
    }
    
    func editUpdate() {
        switch self.presentEdit {
        case .Ingredient:
            self.ingredients[self.itemIndexEdit] = itemEditInput
        case .Instruction:
            self.instructions[self.itemIndexEdit] = itemEditInput
        case .none: break
        }
        self.closeEdit()
    }
    
    func setCookingRecipe(_ menu: CookingRecipe) {
        self.mCookingRecipe = menu
        self.title = menu.title
        self.photoUrl = menu.photoUrl
        self.ingredients = menu.ingredients
        self.instructions = menu.instructions
        self.refUrl = menu.refUrl ?? ""
    }
    
    func saveMenu() {
        self.fetchState = .isLoading
        let timestamp = mCookingRecipe?.timestamp ?? Timestamp()
        let menu = CookingRecipe(
            title: self.title,
            photoUrl: self.photoUrl,
            ingredients: self.ingredients,
            instructions: self.instructions,
            timestamp: timestamp,
            refUrl: self.refUrl
        )
        let onCompletedBlock: ((String?) -> Void) = { error in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.fetchState = .start
                if let err = error {
                    self.messageError = err
                } else {
                    self.isGoBack.toggle()
                }
            }
        }
        if let uid = mCookingRecipe?.uid {
            CookingService.shared.updateMenu(withId: uid, menu: menu, completed: onCompletedBlock)
        } else {
            CookingService.shared.addMenu(withMenu: menu, completed: onCompletedBlock)
        }
    }
    
    func delete() {
        guard let id = mCookingRecipe?.uid else {
            return
        }
        self.fetchState = .isLoading
        CookingService.shared.deleteMenu(with: id) { error in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.fetchState = .start
                if let err = error {
                    self.messageError = err
                } else {
                    self.isGoBackToRoot.toggle()
                }
            }
        }
    }
}
