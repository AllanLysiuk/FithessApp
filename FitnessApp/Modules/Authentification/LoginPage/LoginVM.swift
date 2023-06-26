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
    
    func login(email: String, password: String) {
        authService.login(email: email, password: password) { error in
            
        }
    }
    
    func openRegisterPage() {
        coordinator?.openRegisterScene()
    }
    
    func openForgotPasswordPage() {
        coordinator?.openForgotPasswordScene()
    }
    
}
