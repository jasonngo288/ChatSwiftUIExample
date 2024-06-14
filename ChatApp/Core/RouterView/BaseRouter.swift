//
//  BaseRouter.swift
//  ChatApp
//
//  Created by Jason Ngo on 12/06/2024.
//

import Foundation
import SwiftUI
import Combine

class BaseRouter: ObservableObject {
    
    // Used to programatically control our navigation stack
    @Published var paths: NavigationPath = NavigationPath()
    
    var listPaths: [(any Hashable)] = []
    
    private var subscription = Set<AnyCancellable>()

    func getCurrentPath() -> (any Hashable)? {
        return listPaths.last
    }
    
    init() {
        $paths.sink {[weak self] path in
            let count = (self?.listPaths.count ?? 0)
            if count > 0, path.count != count { // navigation button back pressed
                self?.listPaths.removeLast(count - path.count)
            }
        }.store(in: &subscription)
    }
}

extension BaseRouter: NavigationCoordinator {
    
    // Used by views to push to another or self view
    func pushTo(_ path: any Hashable) {
        DispatchQueue.main.async { [weak self] in
            self?.listPaths.append(path)
            self?.paths.append(path)
        }
    }
    
    // Used by views to navigate to another view
    func navigateTo(_ path: any Hashable) {
        if path.hashValue == getCurrentPath()?.hashValue {
            return
        }
        DispatchQueue.main.async { [weak self] in
            self?.listPaths.append(path)
            self?.paths.append(path)
        }
    }
    
    // Used to go back to the previous screen
    // Before
    // Used by views to navigate to another view
    func popAndNavigateTo(_ path: any Hashable) {
        self.navigateBack()
        self.navigateTo(path)
    }
    
    // Used to go back to the previous screen
    func navigateBack() {
        DispatchQueue.main.async { [weak self] in
            self?.listPaths.removeLast()
            self?.paths.removeLast()
        }
    }
    
    // Pop to the root screen in our hierarchy
    func popToRoot() {
        self.popToRoot(index: self.paths.count)
    }
    
    
    // Pop with index to a screen in our hierarchy
    func popToRoot(index: Int) {
        DispatchQueue.main.async { [weak self] in
            if let _count = self?.paths.count, _count >= index {
                self?.listPaths.removeLast(index)
                self?.paths.removeLast(index)
            }
        }
    }
    
}
