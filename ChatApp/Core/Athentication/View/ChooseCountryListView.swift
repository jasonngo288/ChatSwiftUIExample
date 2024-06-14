//
//  ChooseCountryListView.swift
//  ChatApp
//
//  Created by Jason Ngo on 21/05/2024.
//

import SwiftUI

struct ChooseCountryListView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = ChooseCountryListViewModel()
    var onDone:((Country)->Void)
    
    var body: some View {
        NavigationStack {
            if viewModel.countryList.isEmpty {
                Text("No records")
                    .listRowBackground(EmptyView())
            }
            List(viewModel.countryList) { country in
                if country.name.isEmpty {
                    Text("no country name")
                } else {
                    HStack{
                        Text(country.name).font(.title2)
                        Spacer()
                        Text(country.dia).font(.subheadline)
                    }.onTapGesture(perform: {
                        self.onDone(country)
                        self.dismiss()
                    })
                }
            }
            .searchable(text: $viewModel.searchTerm)
            .navigationTitle(Text("Choose your country"))
            .onAppear {
                viewModel.loadData()
            }
        }
    }
}

#Preview {
    ChooseCountryListView { _ in }
}
