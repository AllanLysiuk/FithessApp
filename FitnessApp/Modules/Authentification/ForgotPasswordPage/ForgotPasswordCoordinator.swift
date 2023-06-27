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
        assert(false, "Should be open with arguments, please use start(delegate: , email: )")
    }
    
    func start(delegate: ForgotPasswordLoginDelegate, email: String?) {
        let vc = ForgotPasswordAssembler.makeVC(coordinator: self, container: container, delegate: delegate, email: email)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func finish() {
        rootCoordinator.forgotPasswordFinished(self)
    }
}

extension ForgotPasswordCoordinator: ForgotPasswordCoordinatorProtocol {
    func presentAlert(_ alert: UIViewController) {
        navigationController.present(alert, animated: true)
    }
    
    func finish(shouldMoveToParent: Bool) {
        if shouldMoveToParent {
            navigationController.popViewController(animated: true)
        }
        finish()
    }
}
