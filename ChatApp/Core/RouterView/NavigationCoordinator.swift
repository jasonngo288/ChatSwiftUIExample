//
//  NavigationCoordinator.swift
//  ChatApp
//
//  Created by Jason Ngo on 12/06/2024.
//

import Foundation

public protocol NavigationCoordinator {
    
    func navigateTo(_ path: any Hashable)
    func pushTo(_ path: any Hashable)
    func popAndNavigateTo(_ path: any Hashable)
    func navigateBack()
    func popToRoot()
    func popToRoot(index: Int)
}
