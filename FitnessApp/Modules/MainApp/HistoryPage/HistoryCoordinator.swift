//
//  HistoryCoordinator.swift
//  FitnessApp
//
//  Created by Allan on 23.06.23.
//

import Foundation

import UIKit

final class HistoryCoordinator: Coordinator {
    private var tabBarController: UITabBarController
    private var rootCoordinator: HistoryRootCoordinatorProtocol
    var childCoordinators: [Coordinator] = []
    
    init(tabBarController: UITabBarController, rootCoordinator: HistoryRootCoordinatorProtocol) {
        self.tabBarController = tabBarController
        self.rootCoordinator = rootCoordinator
    }
    
    func start() {
        let vc = HistoryAssembler.makeHistoryVC(coordinator: self)
        tabBarController.addChild(vc)
    }
    
    func finish() {
        tabBarController.removeFromParent()
        rootCoordinator.historyFinished(self) 
    }
}

extension HistoryCoordinator: HistoryCoordinatorProtocol {
    
}
