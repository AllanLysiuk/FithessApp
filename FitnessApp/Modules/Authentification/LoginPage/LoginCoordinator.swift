//
//  LoginCoordinator.swift
//  FitnessApp
//
//  Created by Allan on 22.06.23.
//

import Foundation
import UIKit

final class LoginCoordinator: Coordinator {
    private var rootCoordinator: LoginRootCoordinatorProtocol
    private var rootNavigationController: UINavigationController
    private var container: Container
    var childCoordinators: [Coordinator] = []
    
    init(
        rootNavigationController: UINavigationController,
        rootCoordinator: LoginRootCoordinatorProtocol,
        container: Container
    ) {
            self.rootNavigationController = rootNavigationController
            self.rootCoordinator = rootCoordinator
            self.container = container
        }
    
    func start() {
        let vc = LoginAssembler.makeVC(container: container, coordinator: self)
        rootNavigationController.pushViewController(vc, animated: false)
    }
    
    func finish() {
        rootNavigationController.popViewController(animated: true)
        rootCoordinator.loginFinished(self)
    }
    
    
}

extension LoginCoordinator: LoginCoordinatorProtocol {
    func openRegisterScene() {
        let coordinator = RegisterCoordinator(
            navigationController: rootNavigationController,
            rootCoordinator: self,
            container: container
        )
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func openForgotPasswordScene() {
        let coordinator = ForgotPasswordCoordinator(
            navigationController: rootNavigationController,
            rootCoordinator: self,
            container: container
        )
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}


extension LoginCoordinator: RegisterRootCoordinatorProtocol {
    func registerFinished(_ coordinator: Coordinator) {
        childCoordinators.removeAll(where: { $0 === coordinator })
    }
}

extension LoginCoordinator: ForgotPasswordRootCoordinatorProtocol {
    func forgotPasswordFinished(_ coordinator: Coordinator) {
        childCoordinators.removeAll(where: { $0 === coordinator })
    }
}
