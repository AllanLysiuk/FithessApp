//
//  OnBoardingCoordinator.swift
//  FitnessApp
//
//  Created by Allan on 29.06.23.
//

import Foundation
import UIKit

final class OnBoardingCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    private var rootNavigationController: UINavigationController
    private var container: Container
    private var rootCoordinator: OnBoardingRootCoordinatorProtocol
    
    init(
        rootNavigationController: UINavigationController,
         rootCoordinator: OnBoardingRootCoordinatorProtocol,
        container: Container
    ) {
        self.rootCoordinator = rootCoordinator
        self.rootNavigationController = rootNavigationController
        self.container = container
    }
    
    func start() {
        let vc = OnBoardingAssembler.makeOnBoardingVC(coordinator: self, container: container)
        rootNavigationController.pushViewController(vc, animated: false)
    }
    
    func finish() {
        rootNavigationController.popViewController(animated: false)
        rootCoordinator.finishedOnBoarding(self)
    }
    
    
}

extension OnBoardingCoordinator: OnBoardingCoordinatorProtocol{
    func presentImagePicker(_ imagePicker: ViewContext) {
        rootNavigationController.present(imagePicker.viewController, animated: true)
    }
    
    func dismissImagePicker() {
        rootNavigationController.dismiss(animated: true)
    }
}
