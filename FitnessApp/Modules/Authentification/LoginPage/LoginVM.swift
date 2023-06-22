//
//  LoginVM.swift
//  FitnessApp
//
//  Created by Allan on 22.06.23.
//

import Foundation
import UIKit

final class LoginVM: LoginVMProtocol {
    private weak var coordinator: LoginCoordinatorProtocol?
    
    init(coordinator: LoginCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func login() {
        print("Login")
    }
    
    func openRegisterPage() {
        coordinator?.openRegisterScene()
    }
    
    func openForgotPasswordPage() {
        coordinator?.openForgotPasswordScene()
    }
    
}
