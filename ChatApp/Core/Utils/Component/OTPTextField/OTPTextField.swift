//
//  OTPTextField.swift
//  ChatApp
//
//  Created by Jason Ngo on 21/05/2024.
//

import SwiftUI

struct OTPTextField: View {
    @StateObject var viewModel = OTPTextFieldViewModel()
    @FocusState private var isFocused: Bool
    
    private let textBoxWidth = UIScreen.main.bounds.width / 8
    private let textBoxHeight = UIScreen.main.bounds.width / 8
    private let spaceBetweenBoxes: CGFloat = 10
    private let paddingOfBox: CGFloat = 1
    private var textFieldOriginalWidth: CGFloat {
        (textBoxWidth*6)+(spaceBetweenBoxes*3)+((paddingOfBox*2)*3)
    }
    var onVerifyOTP:((String)->Void)?
    
    var body: some View {
        
        VStack {
            
            ZStack {
                
                HStack (spacing: spaceBetweenBoxes){
                    
                    otpText(text: viewModel.otp1)
                    otpText(text: viewModel.otp2)
                    otpText(text: viewModel.otp3)
                    otpText(text: viewModel.otp4)
                    otpText(text: viewModel.otp5)
                    otpText(text: viewModel.otp6)
                }
                
                TextField("", text: $viewModel.otpField)
                    .frame(width: isFocused ? 0 : textFieldOriginalWidth, height: textBoxHeight)
                    .disabled(viewModel.isTextFieldDisabled)
                    .textContentType(.oneTimeCode)
                    .foregroundColor(.clear)
                    .accentColor(.clear)
                    .background(Color.clear)
                    .keyboardType(.numberPad)
                    .focused($isFocused)
                    .toolbar{
                        ToolbarItemGroup(placement: .keyboard) {
                            //Spacer()
                            Button("Send"){
                                if viewModel.otpField.count == 6 {
                                    onVerifyOTP?(viewModel.otpField)
                                }
                            }
                            //.disabled(viewModel.otp6.isEmpty)
                        }
                    }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isFocused = true
            }
        }
    }
    
    private func otpText(text: String) -> some View {
        
        return Text(text)
            .font(.title)
            .frame(width: textBoxWidth, height: textBoxHeight)
            .background(VStack{
                Spacer()
                RoundedRectangle(cornerRadius: 1)
                    .frame(height: 0.5)
            })
            .padding(paddingOfBox)
    }
}

#Preview {
    OTPTextField()
}
