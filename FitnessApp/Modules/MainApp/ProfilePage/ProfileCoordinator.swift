//
//  ProfileCoordinator.swift
//  FitnessApp
//
//  Created by Allan on 23.06.23.
//

import Foundation
import UIKit

final class ProfileCoordinator: Coordinator {
    private var tabBarController: UITabBarController
    private var rootCoordinator: ProfileRootCoordinatorProtocol
    var childCoordinators: [Coordinator] = []
    
    init(tabBarController: UITabBarController, rootCoordinator: ProfileRootCoordinatorProtocol) {
        self.tabBarController = tabBarController
        self.rootCoordinator = rootCoordinator
    }
    
    func start() {
        let vc = ProfileAssembler.makeProfileVC(coordinator: self)
        tabBarController.addChild(vc)
    }
    
    func finish() {
        tabBarController.removeFromParent()
        rootCoordinator.profileFinished(self)
    }
}

extension ProfileCoordinator: ProfileCoordinatorProtocol {
    
}
