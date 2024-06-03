//
//  AddNewCookingRecipeViewModel.swift
//  ChatApp
//
//  Created by Jason Ngo on 30/05/2024.
//

import Foundation


class AddNewCookingRecipeViewModel: ObservableObject {
 
    @Published var title: String = ""
    @Published var photoUrl: String = ""
    @Published var ingredients: [String] = []
    @Published var ingredientInput: String = ""
    
    @Published var instructions: [String] = []
    @Published var instructionInput: String = ""
    
    @Published var isGoBack: Bool = false
    @Published var messageError: String = ""
    
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
    
    func saveMenu() {
        let menu = CookingRecipe(title: self.title, photoUrl: self.photoUrl, ingredients: self.ingredients, instructions: self.instructions)
        CookingService.shared.addMenu(withMenu: menu) { error in
            if let err = error {
                self.messageError = err
            } else {
                self.isGoBack.toggle()
            }
        }
    }
    
}
