//
//  RegisterVM.swift
//  FitnessApp
//
//  Created by Allan on 22.06.23.
//

import Foundation

final class RegisterVM: RegisterVMProtocol {
    private weak var coordinator: RegisterCoordinatorProtocol?
    private var authService: RegisterAuthServiceProtocol
    private var alertFactory: AlertControllerFactoryProtocol
    private weak var delegate: RegisterLoginDelegate?
    var email: String?
    
    init(
        coordinator: RegisterCoordinatorProtocol,
        authService: RegisterAuthServiceProtocol,
        alertFactory: AlertControllerFactoryProtocol,
        delegate: RegisterLoginDelegate,
        email: String?
    ) {
        self.coordinator = coordinator
        self.authService = authService
        self.alertFactory = alertFactory
        self.delegate = delegate
        self.email = email
    }
    
    func register(email: String?, password: String?, checkPassword: String?) {
        if password != checkPassword {
            openAlert(title: "Incorrect Input", message: "Passwords are different, try one more time", shouldCloseScreen: false)
            return
        }
        
        if let email = email, let password = password, let checkPassword = checkPassword, (email != "" && password != "" && checkPassword != "") {
            authService.register(email: email, password: password) { error in
                if error == nil {
                    self.delegate?.registerFinished(with: email)
                    self.openAlert(title: "Register operation", message: "You've succsesfully signed up", shouldCloseScreen: true)
                } else {
                    self.openAlert(title: "Error", message: error?.localizedDescription, shouldCloseScreen: false)
                }
            }
        } else {
            openAlert(title: "Wrong Input", message: "Email or password can't be empty", shouldCloseScreen: false)
            return
        }
    }
    
    private func openAlert(title: String?, message: String?, shouldCloseScreen: Bool) {
        let alert = alertFactory.makeAlert(title: title, message: message, actions: [
            .default("Ok", {
                if shouldCloseScreen {
                    self.finish(shouldMoveToParent: true)
                }
            })
        ])
        coordinator?.presentAlert(ViewContext(viewController: alert))
    }
    
    func finish(shouldMoveToParent: Bool) {
        delegate?.registerFinished(with: email ?? "")
        coordinator?.finish(shouldMoveToParent: shouldMoveToParent)
    }
    
}
