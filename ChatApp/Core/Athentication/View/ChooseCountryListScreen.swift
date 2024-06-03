//
//  ChooseCountryListScreen.swift
//  ChatApp
//
//  Created by Jason Ngo on 21/05/2024.
//

import SwiftUI

struct ChooseCountryListScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = ChooseCountryListViewModel()
    var onDismiss: ((_ model: Country) -> Void)?
    var body: some View {
        NavigationView {
            List(viewModel.countryList) { country in
                if country.name.isEmpty {
                    Text("no country name")
                } else {
                    HStack{
                        Text(country.name).font(.title2)
                        Spacer()
                        Text(country.dia).font(.subheadline)
                    }.onTapGesture(perform: {
                        onDismiss?(country)
                        presentationMode.wrappedValue.dismiss()
                    })
                }
            }
        }
        .navigationTitle(Text("Choose your country"))
        .onAppear {
            viewModel.loadData()
        }
    }
}

#Preview {
    ChooseCountryListScreen()
}
