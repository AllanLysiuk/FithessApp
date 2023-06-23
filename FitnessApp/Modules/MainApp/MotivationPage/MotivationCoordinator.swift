//
//  MotivationCoordinator.swift
//  FitnessApp
//
//  Created by Allan on 23.06.23.
//

import Foundation
import UIKit

final class MotivationCoordinator: Coordinator {
    private var tabBarController: UITabBarController
    private var rootCoordinator: MotivationRootCoordinatorProtocol
    var childCoordinators: [Coordinator] = []
    
    init(tabBarController: UITabBarController, rootCoordinator: MotivationRootCoordinatorProtocol) {
        self.tabBarController = tabBarController
        self.rootCoordinator = rootCoordinator
    }
    
    func start() {
        let vc = MotivationAssembler.makeMotivationVC(coordinator: self)
        tabBarController.addChild(vc)
    }
    
    func finish() {
        tabBarController.removeFromParent()
        rootCoordinator.motivationFinished(self)
    }
}

extension MotivationCoordinator: MotivationCoordinatorProtocol {
    
}
