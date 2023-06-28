//
//  LoginVM.swift
//  FitnessApp
//
//  Created by Allan on 22.06.23.
//

import Foundation
import UIKit

protocol LoginVCDelegate: AnyObject {
    func setEmail(_ email: String?)
}

final class LoginVM: LoginVMProtocol {
    private var authService: LoginAuthServiceProtocol
    private weak var coordinator: LoginCoordinatorProtocol?
    private var alertFactory: AlertControllerFactoryProtocol
    
    private weak var delegate: LoginVCDelegate?
    
    init(
        coordinator: LoginCoordinatorProtocol,
        authService: LoginAuthServiceProtocol,
        alertFactory: AlertControllerFactoryProtocol
    ) {
        self.coordinator = coordinator
        self.authService = authService
        self.alertFactory = alertFactory
    }
    
    func login(email: String?, password: String?) {
        if let email = email, let password = password, (email != "" && password != "") {
            authService.login(email: email, password: password) { error in
                if let error = error {
                    self.openAlert(title: "Error", message: error.localizedDescription, shouldCloseScreen: false)
                } else {
                    let ud = UserDefaults()
                    ud.set(true, forKey: UserDefaultsEnum.isRegistered)
                    self.openAlert(title: "Login operation", message: "You've succsesfully signed in!", shouldCloseScreen: true)
                }
            }
        } else {
            openAlert(title: "Wrong Input", message: "Email or pasword can't be empty", shouldCloseScreen: false)
            return
        }
    }
    
    func loginWithGoogle(viewContext: ViewContext) {
        authService.signInWithGoogle(viewContext: viewContext) { error in
            if let error = error {
                self.openAlert(title: "Error", message: error.localizedDescription, shouldCloseScreen: false)
            } else {
                let ud = UserDefaults()
                ud.set(true, forKey: UserDefaultsEnum.isRegistered)
                self.openAlert(title: "Login operation", message: "You've succsesfully signed in!", shouldCloseScreen: true)
            }
        }
    }
    
    private func openAlert(title: String?, message: String?, shouldCloseScreen: Bool) {
        let alert = alertFactory.makeAlert(title: title, message: message, actions: [
            .default("Ok", {
                if shouldCloseScreen {
                    self.coordinator?.finish()
                }
            })
        ])
        coordinator?.presentAlert(ViewContext(viewController: alert))
    }
    
    func openRegisterPage(with email: String?) {
        coordinator?.openRegisterScene(delegate: self, email: email)
    }
    
    func openForgotPasswordPage(with email: String?) {
        coordinator?.openForgotPasswordScene(delegate: self, email: email)
    }
    
    func setupViewDelegate(_ delegate: LoginVCDelegate) {
        self.delegate = delegate
    }
    
}

extension LoginVM: RegisterLoginDelegate {
    func registerFinished(with email: String) {
        delegate?.setEmail(email)
    }
}

extension LoginVM: ForgotPasswordLoginDelegate {
    func passwordChanged(with email: String) {
        delegate?.setEmail(email)
    }
}
