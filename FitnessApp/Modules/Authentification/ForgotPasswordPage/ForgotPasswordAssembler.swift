//
//  ForgotPasswordAssembler.swift
//  FitnessApp
//
//  Created by Allan on 22.06.23.
//

import Foundation
import UIKit

final class ForgotPasswordAssembler {
    private init() { }
    
    static func makeVC(coordinator: ForgotPasswordCoordinatorProtocol, container: Container) -> UIViewController {
        let vm = makeVM(coordinator: coordinator, container: container)
        return ForgotPasswordVC(viewModel: vm)
    }
    
    private static func makeVM(coordinator: ForgotPasswordCoordinatorProtocol, container: Container) -> ForgotPasswordVMProtocol {
        return ForgotPasswordVM(coordinator: coordinator, authService: makeAuthService(container: container))
    }
    
    private static func makeAuthService(container: Container) -> AuthServiceProtocol {
        return container.resolve()
    }
}
