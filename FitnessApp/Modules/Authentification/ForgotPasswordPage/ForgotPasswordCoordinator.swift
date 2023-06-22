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
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController, rootCoordinator: ForgotPasswordRootCoordinatorProtocol) {
        self.navigationController = navigationController
        self.rootCoordinator = rootCoordinator
    }
    
    func start() {
        let vc = ForgotPasswordAssembler.makeVC(coordinator: self)
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
