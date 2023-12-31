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
    
    static func makeVC(
        coordinator: ForgotPasswordCoordinatorProtocol,
        container: Container,
        delegate: ForgotPasswordLoginDelegate,
        email: String?
    ) -> UIViewController {
        let vm = makeVM(coordinator: coordinator, container: container, delegate: delegate, email: email)
        return ForgotPasswordVC(viewModel: vm)
    }
    
    private static func makeVM(
        coordinator: ForgotPasswordCoordinatorProtocol,
        container: Container,
        delegate: ForgotPasswordLoginDelegate,
        email: String?
    ) -> ForgotPasswordVMProtocol {
        return ForgotPasswordVM(
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
