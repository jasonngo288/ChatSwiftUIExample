//
//  LoginView.swift
//  ChatApp
//
//  Created by Jason Ngo on 20/05/2024.
//

import SwiftUI

struct LoginScreen: View {
    @StateObject private var viewModel = LoginViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                Spacer().frame(height: 150)
                Text("WhatsApp will need to verify your account. Carrier charges may apply.")
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding()
                VStack {
                    NavigationLink {
                        ChooseCountryListScreen { model in
                            viewModel.setCountry(selected:model)
                        }
                    } label: {
                        HStack {
                            Text(viewModel.country.name)
                                .font(.subheadline)
                                .foregroundColor(.blue)
                            Spacer()
                            Image(systemName: "chevron.right").colorMultiply(.gray)
                        }
                    }
                    .padding(.top, 10)
                    .padding()
                    .background(Color.clear)
                    Divider()
                    HStack{
                        Text(viewModel.country.dia)
                            .font(.subheadline)
                        TextField("Phone number", text: $viewModel.phoneNumber)
                            .font(.subheadline)
                            .keyboardType(.phonePad)
                            .textInputAutocapitalization(.never)
                    }
                    .padding()
                    .background(Color.clear)
                }
                .background(Color.white)
                .cornerRadius(12)
                .padding()
                Spacer()
                Button {
                    viewModel.sendCode()
                } label: {
                    Text("Next")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: 360,height: 44)
                        .background(viewModel.phoneNumber.isEmpty ? .gray : .green)
                        .disabled(viewModel.phoneNumber.isEmpty)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.vertical)
            }
            .background(Color(.systemGray6))
        }
        .navigationTitle(Text("Enter your phone number"))
        .alert(isPresented: $viewModel.error) {
            Alert(title: Text("Error"), message: Text(viewModel.errorMsg))
        }
        .navigationDestination(isPresented: $viewModel.goToVerify) {
            VerificationScreen(
                verificationID: viewModel.verificationID,
                phoneNumber: viewModel.country.dia + viewModel.phoneNumber
            )
        }
    }
}

#Preview {
    LoginScreen()
}
