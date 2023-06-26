//
//  ForgotPasswordCoordinator.swift
//  FitnessApp
//
//  Created by Allan on 22.06.23.
//

import Foundation
import UIKit

final class ForgotPasswordCoordinator: Coordinator {
    private var navigationController: UINavigationController
    private var rootCoordinator: ForgotPasswordRootCoordinatorProtocol
    private var container: Container
    var childCoordinators: [Coordinator] = []
    
    init(
        navigationController: UINavigationController,
        rootCoordinator: ForgotPasswordRootCoordinatorProtocol,
        container: Container
    ) {
        self.navigationController = navigationController
        self.rootCoordinator = rootCoordinator
        self.container = container
    }
    
    func start() {
        let vc = ForgotPasswordAssembler.makeVC(coordinator: self, container: container)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func finish() {
        rootCoordinator.forgotPasswordFinished(self)
    }
    
    
}

extension ForgotPasswordCoordinator: ForgotPasswordCoordinatorProtocol {
    func finish(shouldMoveToParent: Bool) {
        if shouldMoveToParent {
            navigationController.popViewController(animated: true)
        }
        finish()
    }
}
