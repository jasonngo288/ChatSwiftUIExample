//
//  RegistrationView.swift
//  ChatApp
//
//  Created by Jason Ngo on 20/05/2024.
//

import SwiftUI

struct VerificationView: View {
    var verificationID: String = ""
    var phoneNumber: String = ""
    
    @StateObject var viewModel = VerificationViewModel()
    @FocusState var isFocusOTPTextField: Bool
    
    var body: some View {
        NavigationView {
            LoadingIndicator(isShowing: $viewModel.loading) {
                VStack {
                    Spacer().frame(height: 50)
                    Image(systemName: "iphone.sizes")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .scaledToFill()
                    Text("Use your other phone to confirm moving WhatsApp to this one \n\n Open WhatsApp on your other phone to get the 6-digit code. Enter it here.")
                        .multilineTextAlignment(.center)
                        .padding()
                    OTPTextField { otpCode in
                        viewModel.verifyCode(code: otpCode)
                    }
                    .padding(.bottom, 12)
                    Text("Need help getting a code?")
                        .font(.body)
                        .foregroundColor(.gray)
                    if viewModel.showSendAgain {
                        Button {
                            viewModel.resendCode(phone: self.phoneNumber)
                        } label: {
                            Text("Resend code").foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        }
                    } else {
                        HStack{
                            Text("You may request a new code in")
                            Text("0:\(viewModel.sendCodeAgainTime)").fontWeight(.semibold)
                        }
                    }
                    Spacer()
                }
            }
        }
        .onAppear {
            viewModel.setVerificationCode(verificationID: self.verificationID)
        }
        .alert(isPresented: $viewModel.error) {
            Alert(title: Text("Error"), message: Text(viewModel.errorMsg))
        }
        .navigationTitle(phoneNumber)
    }
}

#Preview {
    VerificationView()
}
