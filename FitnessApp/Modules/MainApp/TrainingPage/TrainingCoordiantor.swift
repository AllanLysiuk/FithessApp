//
//  TrainingCoordiantor.swift
//  FitnessApp
//
//  Created by Allan on 23.06.23.
//

import Foundation
import UIKit

final class TrainingCoordiantor: Coordinator {
    private var tabBarController: UITabBarController
    private var rootCoordinator: TrainingRootCoordinatorProtocol
    private var container: Container
    var childCoordinators: [Coordinator] = []
    
    init(
        tabBarController: UITabBarController,
        rootCoordinator: TrainingRootCoordinatorProtocol,
        container: Container
    ) {
        self.tabBarController = tabBarController
        self.rootCoordinator = rootCoordinator
        self.container = container
    }
    
    func start() {
        let vc = TrainingAssembler.makeTrainingVC(coordinator: self, container: container)
        tabBarController.addChild(vc)
    }
    
    func finish() {
        tabBarController.removeFromParent()
        rootCoordinator.trainingFinished(self)
    }
}

extension TrainingCoordiantor: TrainingCoordinatorProtocol {
    
}
