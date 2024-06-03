//
//  RootViewModel.swift
//  ChatApp
//
//  Created by Jason Ngo on 20/05/2024.
//

import Foundation
import FirebaseAuth
import Combine

class RootViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var isGoToUpdateProfile: Bool = false
    
    private var cancellable = Set<AnyCancellable>()
    private var userService = UserService.shared
    
    init() {
       setupSubscribers()
    }

     private func setupSubscribers() {
        AuthService.shared.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
            self?.checkUserLoggedIn()
        }
        .store(in: &cancellable)
    }
    
    func checkUserLoggedIn() {
        Task {
            try await userService.fetchCurrentUser {
                self.checkLogic()
            }
        }
    }
    
    func checkLogic() {
        DispatchQueue.main.async {
            if (self.userSession != nil), (self.userService.currentUser == nil) {
                self.isGoToUpdateProfile.toggle()
            }
        }
    }
}
