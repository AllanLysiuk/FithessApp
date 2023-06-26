//
//  RegisterAssembler.swift
//  FitnessApp
//
//  Created by Allan on 22.06.23.
//

import Foundation
import UIKit

final class RegisterAssembler {
    
    private init() { }
    
    static func makeRegisterVC(coordinator: RegisterCoordinatorProtocol, container: Container) -> UIViewController {
        let vm = makeViewModel(coordinator: coordinator, container: container)
        return RegisterVC(viewModel: vm)
    }
    
    private static func makeViewModel(coordinator: RegisterCoordinatorProtocol, container: Container) -> RegisterVMProtocol {
        return RegisterVM(coordinator: coordinator, authService: makeAuthService(container: container))
    }
    
    private static func makeAuthService(container: Container) -> AuthServiceProtocol {
        return container.resolve()
    }
}
