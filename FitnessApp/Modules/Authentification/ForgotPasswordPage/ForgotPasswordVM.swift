//
//  ForgotPasswordVM.swift
//  FitnessApp
//
//  Created by Allan on 22.06.23.
//

import Foundation

final class ForgotPasswordVM: ForgotPasswordVMProtocol {
    private weak var coordinator: ForgotPasswordCoordinatorProtocol?
    private var authService: ForgotPasswordAuthServiceProtocol
    private let alertFactory: AlertControllerFactoryProtocol

    private weak var delegate: ForgotPasswordLoginDelegate?
    var email: String?
    
    init(
        coordinator: ForgotPasswordCoordinatorProtocol,
        authService: ForgotPasswordAuthServiceProtocol,
        alertFactory: AlertControllerFactoryProtocol,
        delegate: ForgotPasswordLoginDelegate?,
        email: String?
    ) {
        self.coordinator = coordinator
        self.authService = authService
        self.alertFactory = alertFactory
        self.delegate = delegate
        self.email = email
    }
    
    func forgotPassword(email: String?) {
        if let email = email, email != "" {
            authService.forgotPassword(email: email){ error in
                if error == nil {
                    self.delegate?.passwordChanged(with: email)
                    self.openAlert(title: "Change password operation", message: "You've succsesfully changed password", shouldCloseScreen: true)
                } else {
                    self.openAlert(title: "Error", message: error?.localizedDescription, shouldCloseScreen: false)
                }
            }
        }else {
            openAlert(title: "Wrong Input", message: "Email can't be empty", shouldCloseScreen: false)
            return
        }
    }
    
    private func openAlert(title: String?, message: String?, shouldCloseScreen: Bool) {
        let alert = alertFactory.makeAlert(title: title, message: message, actions: [
            .default("Ok", {
            if shouldCloseScreen {
                self.finish(shouldMoveToParent: true)
            }
        })])
        coordinator?.presentAlert(ViewContext(viewController: alert))
    }
    
    func finish(shouldMoveToParent: Bool) {
        delegate?.passwordChanged(with: email ?? "")
        coordinator?.finish(shouldMoveToParent: shouldMoveToParent)
    }
    
}

