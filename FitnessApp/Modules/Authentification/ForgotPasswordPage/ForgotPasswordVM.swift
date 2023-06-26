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
    
    init(coordinator: ForgotPasswordCoordinatorProtocol, authService: ForgotPasswordAuthServiceProtocol) {
        self.coordinator = coordinator
        self.authService = authService
    }
    
    func forgotPassword(email: String?) {
        if let email = email, email != "" {
            authService.forgotPassword(email: email){ error in
                
            }
        }else {
            //alert
            return
        }
    }
    
    func finish(shouldMoveToParent: Bool) {
        coordinator?.finish(shouldMoveToParent: shouldMoveToParent)
    }
    
}

