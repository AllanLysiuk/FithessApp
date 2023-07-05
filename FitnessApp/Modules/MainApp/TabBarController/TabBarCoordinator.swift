//
//  TabBarCoordinator.swift
//  FitnessApp
//
//  Created by Allan on 23.06.23.
//

import Foundation

import UIKit

final class TabBarCoordinator: Coordinator {
    
    private var rootNavigationController: UINavigationController
    private var rootCoordinator: TabBarRootCoordinatorProtocol
    private var container: Container
    
    var childCoordinators: [Coordinator] = []
    
    init(
        rootNavigationController: UINavigationController,
        rootCoordinator: TabBarRootCoordinatorProtocol,
        container: Container
    ) {
        self.rootNavigationController = rootNavigationController
        self.rootCoordinator = rootCoordinator
        self.container = container
    }
    
    func start() {
        let tabBar = TabBarAssembler.makeTabBarController(coordinator: self)
        rootNavigationController.navigationBar.isHidden = true
        
        generateTrainItem(tabBar)
        generateHistoryItem(tabBar)
        generateMotivationItem(tabBar)
        generateProfileItem(tabBar)
        
        rootNavigationController.pushViewController(tabBar, animated: true)
    }
    
    func finish() {
        rootNavigationController.popViewController(animated: false)
        rootCoordinator.mainSceneFinished(self)
    }
}

extension TabBarCoordinator {
    
    private func generateProfileItem(_ tabBar: UITabBarController) {
        let coordinator = ProfileCoordinator(tabBarController: tabBar, rootCoordinator: self, container: container)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    private func generateTrainItem(_ tabBar: UITabBarController) {
        let coordinator = TrainingCoordiantor(tabBarController: tabBar, rootCoordinator: self)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    private func generateHistoryItem(_ tabBar: UITabBarController) {
        let coordinator = HistoryCoordinator(tabBarController: tabBar, rootCoordinator: self)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    private func generateMotivationItem(_ tabBar: UITabBarController) {
        let coordinator = MotivationCoordinator(tabBarController: tabBar, rootCoordinator: self)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}

extension TabBarCoordinator: TabBarCoordinatorProtocol { }

extension TabBarCoordinator: TrainingRootCoordinatorProtocol {
    func trainingFinished(_ coordinator: Coordinator) { }
}

extension TabBarCoordinator: HistoryRootCoordinatorProtocol {
    func historyFinished(_ coordinator: Coordinator) { }
}

extension TabBarCoordinator: ProfileRootCoordinatorProtocol {
    func profileFinished(_ coordinator: Coordinator) {
        childCoordinators = []
        rootNavigationController.popViewController(animated: false)
        rootCoordinator.mainSceneFinished(self)
    }
}

extension TabBarCoordinator: MotivationRootCoordinatorProtocol {
    func motivationFinished(_ coordinator: Coordinator) { }
}
