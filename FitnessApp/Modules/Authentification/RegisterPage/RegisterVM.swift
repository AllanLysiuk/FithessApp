//
//  RegisterVM.swift
//  FitnessApp
//
//  Created by Allan on 22.06.23.
//

import Foundation

final class RegisterVM: RegisterVMProtocol {
    private weak var coordinator: RegisterCoordinatorProtocol?
    
    init(coordinator: RegisterCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func register() {
        
    }
    
    func finish(shouldMovetoParentVC: Bool) {
        coordinator?.finish(shouldMovetoParentVC: shouldMovetoParentVC)
    }
    
}
