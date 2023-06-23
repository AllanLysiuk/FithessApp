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
    var childCoordinators: [Coordinator] = []
    
    init(tabBarController: UITabBarController, rootCoordinator: TrainingRootCoordinatorProtocol) {
        self.tabBarController = tabBarController
        self.rootCoordinator = rootCoordinator
    }
    
    func start() {
        let vc = TrainingAssembler.makeTrainingVC(coordinator: self) 
        tabBarController.addChild(vc)
    }
    
    func finish() {
        tabBarController.removeFromParent()
        rootCoordinator.trainingFinished(self)
    }
}

extension TrainingCoordiantor: TrainingCoordinatorProtocol {
    
}
