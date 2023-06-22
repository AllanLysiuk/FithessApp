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
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController, rootCoordinator: RegisterRootCoordinatorProtocol) {
        self.navigationController = navigationController
        self.rootCoordinator = rootCoordinator
    }
    
    func start() {
        let vc = RegisterAssembler.makeRegisterVC(coordinator: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func finish() {
        rootCoordinator.registerFinished(self)
    }
    
    
}

extension RegisterCoordinator: RegisterCoordinatorProtocol {
    func finish(shouldMovetoParentVC: Bool) {
        if shouldMovetoParentVC {
            navigationController.popViewController(animated: true)
        }
        finish()
    }
}
