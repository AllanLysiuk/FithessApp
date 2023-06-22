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
    
    init (windowScene: UIWindowScene) {
        self.windowScene = windowScene
    }
    
    func start() {
       let isRegistered = false
       // let isRegistered = UserDefaults.standard.bool(forKey: UserDefaultsEnum.isRegistered.rawValue)
        
        if !isRegistered {
            openLoginScene()
        } else {
            openMainScene()
        }
        window?.makeKeyAndVisible()
    }
    
    func finish() {

    }
    
    private func openLoginScene() {
        let loginWindow = UIWindow(windowScene: windowScene)
        let nc = UINavigationController()
        loginWindow.rootViewController = nc
        
        let loginCoordinator = LoginCoordinator(rootNavigationController: nc, rootCoordinator: self)
        childCoordinators.append(loginCoordinator)
        loginCoordinator.start()
        
        window = loginWindow
    }
    
    private func openMainScene() {
      
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

