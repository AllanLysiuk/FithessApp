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
    private var container: Container
    private var navigationController = UINavigationController()
    
    var childCoordinators: [Coordinator] = []
    
    
    init(
        tabBarController: UITabBarController,
        rootCoordinator: ProfileRootCoordinatorProtocol,
        container: Container
    ) {
        self.tabBarController = tabBarController
        self.rootCoordinator = rootCoordinator
        self.container = container
    }
    
    func start() {
        let vc = ProfileAssembler.makeProfileVC(coordinator: self, container: container)
        navigationController.addChild(vc)
        tabBarController.addChild(navigationController)
    }
    
    func finish() {
        tabBarController.removeFromParent()
        rootCoordinator.profileFinished(self)
    }
}

extension ProfileCoordinator: ProfileCoordinatorProtocol {
    func presentImagePicker(_ imagePicker: ViewContext) {
        navigationController.present(imagePicker.viewController, animated: true)
    }
    
    func dismissImagePicker() {
        navigationController.dismiss(animated: true)
    }
}
