//
//  ChooseCountryListViewModel.swift
//  ChatApp
//
//  Created by Jason Ngo on 21/05/2024.
//

import Foundation

class ChooseCountryListViewModel: ObservableObject {
    
    @Published var countryList: [Country] = []

    func loadData() {
        do {
            if let filePath = Bundle.main.path(forResource: "country_list", ofType: "json") {
                let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
                let results = try JSONDecoder().decode([Country].self, from: data)
                countryList = results
            }
        } catch {
            print("----> error: \(error)") // <-- todo, deal with errors
        }
    }
}
