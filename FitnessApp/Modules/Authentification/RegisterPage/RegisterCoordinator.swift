//
//  RegisterCoordinator.swift
//  FitnessApp
//
//  Created by Allan on 22.06.23.
//

import Foundation
import UIKit

final class RegisterCoordinator: Coordinator {
    private var navigationController: UINavigationController
    private var rootCoordinator: RegisterRootCoordinatorProtocol
    private var container: Container
    var childCoordinators: [Coordinator] = []
    
    init(
        navigationController: UINavigationController,
         rootCoordinator: RegisterRootCoordinatorProtocol,
         container: Container
    ) {
        self.navigationController = navigationController
        self.rootCoordinator = rootCoordinator
        self.container = container
    }
    
    func start() {
        assert(false, "Should be open with arguments, please use start(delegate: , email: )")
    }
    
    func start(delegate: RegisterLoginDelegate, email: String?) {
        let vc = RegisterAssembler.makeRegisterVC(delegate: delegate, email: email, coordinator: self, container: container)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func finish() {
        rootCoordinator.registerFinished(self)
    }
    
    
}

extension RegisterCoordinator: RegisterCoordinatorProtocol {
    func finish(shouldMoveToParent: Bool) {
        if shouldMoveToParent {
            navigationController.popViewController(animated: true)
        }
        finish()
    }
    
    func presentAlert(_ alert: ViewContext) {
        navigationController.present(alert.viewController, animated: true)
    }
}
