//
//  AppCoordinator.swift
//  FitnessApp
//
//  Created by Allan on 22.06.23.
//

import Foundation
import UIKit

final class AppCoordinator: Coordinator {
    private var windowScene: UIWindowScene
    private var window: UIWindow?
    var childCoordinators: [Coordinator] = []
    
    private var container: Container = {
        let container = Container()
        ServiceConfigurations.configure(container: container)
        return container
    }()
    
    init (windowScene: UIWindowScene) {
        self.windowScene = windowScene
    }
    
    func start() {
       //let isRegistered = false
        let isRegistered = UserDefaults.standard.bool(forKey: UserDefaultsEnum.isRegistered)
        let onBoardingShowed = UserDefaults.standard.bool(forKey: UserDefaultsEnum.onBoardingShowed)

        if !isRegistered {
            openLoginScene()
        } else if !onBoardingShowed {
            openOnBoarding()
        } else {
            openMainScene()
        }
        window?.makeKeyAndVisible()
    }
    
    func finish() {

    }
    
    private func openOnBoarding() {
        let loginWindow = UIWindow(windowScene: windowScene)
        let nc = UINavigationController()
        loginWindow.rootViewController = nc
        
        let onBoardingCoordinator = OnBoardingCoordinator(
            rootNavigationController: nc,
            rootCoordinator: self,
            container: container)
        childCoordinators.append(onBoardingCoordinator)
        onBoardingCoordinator.start()
        
        window = loginWindow
    }
    
    private func openLoginScene() {
        let loginWindow = UIWindow(windowScene: windowScene)
        let nc = UINavigationController()
        loginWindow.rootViewController = nc
        
        let loginCoordinator = LoginCoordinator(rootNavigationController: nc, rootCoordinator: self, container: container)
        childCoordinators.append(loginCoordinator)
        loginCoordinator.start()
        
        window = loginWindow
    }
    
    private func openMainScene() {
        let mainWindow = UIWindow(windowScene: windowScene)
        let nc = UINavigationController()
        mainWindow.rootViewController = nc
        mainWindow.makeKeyAndVisible()
        
        let tabBarCoordinator = TabBarCoordinator(
            rootNavigationController: nc,
            rootCoordinator: self,
            container: container
        )
        childCoordinators.append(tabBarCoordinator)
        tabBarCoordinator.start()
        
        
        window = mainWindow
    }
    
}


extension AppCoordinator: LoginRootCoordinatorProtocol {
    func loginFinished(_ coordinator: Coordinator) {
        childCoordinators.removeAll { tmp in
            tmp === coordinator
        }
        start()
    }
}

extension AppCoordinator: TabBarRootCoordinatorProtocol {
    func mainSceneFinished(_ coordinator: Coordinator) {
        childCoordinators.removeAll { tmp in
            tmp === coordinator
        }
        start()
    }
}

extension AppCoordinator: OnBoardingRootCoordinatorProtocol {
    func finishedOnBoarding(_ coordinator: Coordinator) {
        childCoordinators.removeAll { tmp in
            tmp === coordinator
        }
        start()
    }
}
