//
//  LoginViewModel.swift
//  ChatApp
//
//  Created by Jason Ngo on 20/05/2024.
//

import Foundation
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var phoneNumber: String = "650-555-1234"
    @Published var country: Country = Country(name: "United States", code: "US", dia: "+1")
    @Published var errorMsg = ""
    @Published var error = false
    @Published var verificationID = ""
    @Published var goToVerify = false
    
    func login() async  {
        do {
            let email = "abc@gmail.com"
            let password = "12345678"
            let _ = try await AuthService.shared.login(withEmail: email, password: password)
        } catch {
            if let commonError = error as? CommonError {
                switch commonError {
                case .Exception(let err):
                    self.errorMsg = err
                }
                self.error.toggle()
            }
        }
    }
    
    func sendCode() {
        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        // +1 650-555-1234
        // code: 052024
        AuthService.shared.sendOTP(phoneNumber: country.dia + phoneNumber) {
            (verificationID,error) in
            if let error = error {
                print(error.localizedDescription)
                self.errorMsg = error.localizedDescription
                self.error.toggle()
                return
            }
            self.verificationID = verificationID ?? ""
            self.goToVerify = true
        }
    }
    
    func setCountry(selected: Country) {
        self.country = selected
    }
}
