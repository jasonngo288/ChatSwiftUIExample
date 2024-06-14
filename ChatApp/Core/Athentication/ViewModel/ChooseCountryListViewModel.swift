//
//  ChooseCountryListViewModel.swift
//  ChatApp
//
//  Created by Jason Ngo on 21/05/2024.
//

import Foundation
import Combine

class ChooseCountryListViewModel: ObservableObject {
    
    @Published var countryList: [Country] = []
    @Published var searchTerm: String = ""
    @Published var countryOriginList: [Country] = []
    private var subscription = Set<AnyCancellable>()

    init() {
        $searchTerm
            .removeDuplicates()
            .dropFirst()
            .debounce(for:.seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                if !term.isEmpty {
                    let list = self?.countryOriginList.filter({ item in
                        return item.name.lowercased().contains(term.lowercased())
                    })
                    if let _list = list {
                        self?.countryList = _list
                    }
                } else if let list = self?.countryOriginList {
                    self?.countryList = list
                }
            }.store(in: &subscription)
    }
    
    func loadData() {
        do {
            if let filePath = Bundle.main.path(forResource: "country_list", ofType: "json") {
                let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
                let results = try JSONDecoder().decode([Country].self, from: data)
                countryList = results
                countryOriginList = results
            }
        } catch {
            print("----> error: \(error)") // <-- todo, deal with errors
        }
    }
}
