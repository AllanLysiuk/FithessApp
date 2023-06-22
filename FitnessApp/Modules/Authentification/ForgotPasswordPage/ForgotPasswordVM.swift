//
//  ForgotPasswordVM.swift
//  FitnessApp
//
//  Created by Allan on 22.06.23.
//

import Foundation

final class ForgotPasswordVM: ForgotPasswordVMProtocol {
    private weak var coordinator: ForgotPasswordCoordinatorProtocol?
    
    init(coordinator: ForgotPasswordCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func forgotPassword() {
        
    }
    
    func finish(shouldMoveToParent: Bool) {
        coordinator?.finish(shouldMoveToParent: shouldMoveToParent)
    }
    
}

