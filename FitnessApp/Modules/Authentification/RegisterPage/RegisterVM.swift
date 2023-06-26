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
    
    init(coordinator: RegisterCoordinatorProtocol, authService: RegisterAuthServiceProtocol) {
        self.coordinator = coordinator
        self.authService = authService
    }
    
    func register(email: String?, password: String?, checkPassword: String?) {
        if password != checkPassword {
            //add alert
            return
        }
        
        if let email = email, let password = password, let checkPassword = checkPassword, (email != "" && password != "" && checkPassword != "") {
        authService.register(email: email, password: password) { error in
            
            }
        } else {
            //alert
            return
        }
    }
    func finish(shouldMoveToParent: Bool) {
        coordinator?.finish(shouldMoveToParent: shouldMoveToParent)
    }
    
}
