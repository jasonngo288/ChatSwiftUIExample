//
//  AuthService.swift
//  ChatApp
//
//  Created by Jason Ngo on 20/05/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseFirestore


class AuthService {
    
    @Published var userSession: FirebaseAuth.User?
    static let shared = AuthService()
    
    init() {
        self.userSession = Auth.auth().currentUser
        loadCurrentUserData()
    }
    @MainActor
    func login(withEmail email: String,password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            loadCurrentUserData()
        } catch {
            throw CommonError.Exception(err: "failed to login with error \(error.localizedDescription)")
        }
    }
    @MainActor
    func uploadUserData(withUser user: User) async throws {
        do {
            self.userSession = Auth.auth().currentUser
            try await self.uploadUserData(user: user)
            loadCurrentUserData()
        } catch {
            throw CommonError.Exception(err: "failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func sendOTP(phoneNumber: String, completion: @escaping((String?, Error?)->Void)) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID,error) in
            completion(verificationID,error)
        }
    }
    
    func verifyPhoneNumber(withID id: String, code: String, completion: @escaping((Error?)->Void)) {
        let authCredential = PhoneAuthProvider.provider().credential(withVerificationID: id, verificationCode: code)
        Auth.auth().signIn(with: authCredential) { (result, error) in
            if let err = error {
                //throw CommonError.Exception(err: "failed to login with error \(error.localizedDescription)")
                completion(err)
                print(err)
            } else  {
                print(result as Any)
                self.userSession = result?.user
                self.loadCurrentUserData()
                completion(nil)
            }
        }
    }
    func signout() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            UserService.shared.currentUser = nil
        } catch {
            print("failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    private func uploadUserData(user: User) async throws {
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
        try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
    }
    
    private func loadCurrentUserData() {
        Task { try await UserService.shared.fetchCurrentUser()}
    }
    
}
