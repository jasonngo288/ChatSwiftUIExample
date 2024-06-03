//
//  RegistrationViewModel.swift
//  ChatApp
//
//  Created by Jason Ngo on 22/05/2024.
//

import Foundation
import FirebaseAuth
import PhotosUI
import CoreTransferable
import SwiftUI

class ProfileUpdateInfoViewModel: ObservableObject {
    
    @Published var profileUrl: String = ""
    @Published var fullName: String = ""
    @Published var phoneNunber: String = ""
    @Published var about: String = ""
    @Published var currentUser: User?
    @Published private(set) var imageState: ImageState = .empty
    @Published var imageSelected: UIImage? = nil
    @Published var showLoading: Bool = false
    @Published var isGoNextScreen: Bool = false
    
    init(){
        currentUser = UserService.shared.currentUser
        phoneNunber = Auth.auth().currentUser?.phoneNumber ?? ""
        about = currentUser?.about ?? "Hey there! I am using WhatsApp."
        fullName = currentUser?.fullName ?? ""
    }
    
    func saveInfoUser() {
        self.loading()
        func goAhead() {
            Task {
                do{
                    try await self.sendUserInfo()
                    self.loading()
                    DispatchQueue.main.async {
                        self.isGoNextScreen.toggle()
                    }
                }catch {
                    print("Error \(error.localizedDescription)")
                    self.loading()
                }
            }
        }
        if let image = imageSelected {
            uploadProfileAvatar(image: image) {
                goAhead()
            }
        } else {
            goAhead()
        }
    }
    
    private func loading() {
        DispatchQueue.main.async {
            self.showLoading.toggle()
        }
    }
    
    func setImageSelection(from image: UIImage) {
        self.imageSelected = image
        self.imageState = .success(
            Image(uiImage: image).resizable()
        )
    }
    
    private func sendUserInfo() async throws {
        var user = User(fullName: self.fullName, phoneNumber: self.phoneNunber)
        if let uuid = Auth.auth().currentUser?.uid {
            user.uid = uuid
        }
        user.about = self.about
        user.profileImageUrl = self.profileUrl
        try await AuthService.shared.uploadUserData(withUser: user)
    }
    
    private func uploadProfileAvatar(image: UIImage, completed:@escaping(()->Void)) {
        let uid = Auth.auth().currentUser?.uid
        let imageName = "\(uid ?? phoneNunber)"
        UploadFileService.shared.uploadImage(withImage: image, imageName: imageName) {[weak self] url in
            if let _profileUrl = url {
                self?.profileUrl = _profileUrl
            }
            completed()
        }
    }
    
}
