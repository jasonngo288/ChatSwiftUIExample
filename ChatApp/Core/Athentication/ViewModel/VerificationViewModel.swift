//
//  VerificationViewModel.swift
//  ChatApp
//
//  Created by Jason Ngo on 21/05/2024.
//

import Foundation
import FirebaseAuth

class VerificationViewModel: ObservableObject, HeartbeatModifier {
    @Published var errorMsg = ""
    @Published var error = false
    @Published var loading = false
    @Published var showSendAgain = false
    @Published var sendCodeAgainTime = 59
    @Published var verificationID = ""
    
    private var emitter = HeartbeatEmitter()

    init() {
        emitter.delegate = self
    }
    
    deinit {
        emitter.stopTimer()
    }
    
    func beat() {
        if sendCodeAgainTime <= 0 {
            emitter.stopTimer()
            showSendAgain.toggle()
            return
        }
        sendCodeAgainTime -= 1
    }
    
    func verifyCode(code: String)  {
        self.loading.toggle()
        AuthService.shared.verifyPhoneNumber(withID: self.verificationID, code: code) { error in
            self.loading.toggle()
            if let err = error {
                self.errorMsg = err.localizedDescription
                self.error.toggle()
            }
        }
    }
    
    func setVerificationCode(verificationID: String) {
        self.verificationID = verificationID
    }
    
    func resendCode(phone: String) {
        self.loading.toggle()
        AuthService.shared.sendOTP(phoneNumber: phone) { verificationID, error in
            self.loading.toggle()
            if let _err = error {
                self.errorMsg = _err.localizedDescription
                self.error.toggle()
            } else if let _id = verificationID {
                self.setVerificationCode(verificationID: _id)
            }
        }
    }
}
