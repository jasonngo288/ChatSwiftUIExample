//
//  CommunityViewModel.swift
//  ChatApp
//
//  Created by Jason Ngo on 29/05/2024.
//

import Foundation

class CommunityViewModel: ObservableObject {
    
    @Published var listItem: [CookingRecipe] = []
    

    func fetchData() async {
        do{
            let data = try await CookingService.shared.fetchMenuList()
            DispatchQueue.main.async {
                self.listItem = data
            }
        }catch {
            
        }
    }
}
