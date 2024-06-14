//
//  CookingRecipeDetailsViewModel.swift
//  ChatApp
//
//  Created by Jason Ngo on 30/05/2024.
//

import Foundation

class CookingRecipeDetailsViewModel: ObservableObject {
 
    @Published var cookingRecipe: CookingRecipe = CookingRecipe.MOKUP
    @Published var isGoBack: Bool = false
    
    func fetchDataDetail(_ menu: CookingRecipe) {
        Task{
            do{
                if let data = try? await CookingService.shared.fetchMenuDetail(with: menu.id) {
                    DispatchQueue.main.async {
                        self.cookingRecipe = data
                    }
                } else {
                    // NOT FOUND
                    isGoBack.toggle()
                }
            }catch {
                
            }
        }
    }
}
