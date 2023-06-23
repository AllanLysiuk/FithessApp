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
    
    var childCoordinators: [Coordinator] = []
    
    init(rootNavigationController: UINavigationController,
         rootCoordinator: TabBarRootCoordinatorProtocol) {
        self.rootNavigationController = rootNavigationController
        self.rootCoordinator = rootCoordinator
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
      
    }
    
    private func generateTrainItem(_ tabBar: UITabBarController) {
        
    }
    
    private func generateHistoryItem(_ tabBar: UITabBarController) {
        
    }
    
    private func generateMotivationItem(_ tabBar: UITabBarController) {
        
    }
}

extension TabBarCoordinator: TabBarCoordinatorProtocol { }
