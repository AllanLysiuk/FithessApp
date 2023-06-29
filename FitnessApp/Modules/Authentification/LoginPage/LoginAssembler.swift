//
//  LoginAssembler.swift
//  FitnessApp
//
//  Created by Allan on 22.06.23.
//

import Foundation
import UIKit

final class LoginAssembler {
    private init() { }
    
    static func makeVC(container: Container, coordinator: LoginCoordinatorProtocol) -> UIViewController {
        let vm = makeVM(container: container, coordinator: coordinator)
        return LoginVC(viewModel: vm)
    }
    
    private static func makeVM(container: Container, coordinator: LoginCoordinatorProtocol) -> LoginVMProtocol {
        return LoginVM(
            coordinator: coordinator,
            authService: makeAuthService(container: container),
            alertFactory: makeAlertFactory(container: container),
            userDataService: makeUserDataService(container: container)
        )
    }
    
    private static func makeAuthService(container: Container) -> AuthServiceProtocol {
        return container.resolve()
    }
    
    private static func makeAlertFactory(container: Container) -> AlertFactoryProtocol {
        return container.resolve()
    }
    
    private static func makeUserDataService(container: Container) -> UserDataServiceProtocol {
        return container.resolve()
    }
}
