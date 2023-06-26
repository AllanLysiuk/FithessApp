//
//  LoginVM.swift
//  FitnessApp
//
//  Created by Allan on 22.06.23.
//

import Foundation
import UIKit

final class LoginVM: LoginVMProtocol {
    private var authService: LoginAuthServiceProtocol
    private weak var coordinator: LoginCoordinatorProtocol?
    
    init(coordinator: LoginCoordinatorProtocol, authService: LoginAuthServiceProtocol) {
        self.coordinator = coordinator
        self.authService = authService
    }
    
    func login(email: String?, password: String?) {
        if let email = email, let password = password, (email != "" && password != "") {
            authService.login(email: email, password: password) { error in
            
            }
        } else {
           //alert
            return
        }
    }
    
    func openRegisterPage() {
        coordinator?.openRegisterScene()
    }
    
    func openForgotPasswordPage() {
        coordinator?.openForgotPasswordScene()
    }
    
}
