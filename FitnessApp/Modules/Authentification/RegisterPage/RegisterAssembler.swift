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
    
    static func makeRegisterVC(
        delegate: RegisterLoginDelegate,
        email: String?,
        coordinator: RegisterCoordinatorProtocol,
        container: Container
    ) -> UIViewController {
        let vm = makeViewModel(delegate: delegate, coordinator: coordinator, container: container, email: email)
        return RegisterVC(viewModel: vm)
    }
    
    private static func makeViewModel(
        delegate: RegisterLoginDelegate,
        coordinator: RegisterCoordinatorProtocol,
        container: Container,
        email: String?
    ) -> RegisterVMProtocol {
        return RegisterVM(
            coordinator: coordinator,
            authService: makeAuthService(container: container),
            alertFactory: makeAlertFactory(container: container),
            delegate: delegate,
            email: email
        )
    }
    
    private static func makeAuthService(container: Container) -> AuthServiceProtocol {
        return container.resolve()
    }
    
    private static func makeAlertFactory(container: Container) -> AlertFactoryProtocol {
        return container.resolve()
    }
}
