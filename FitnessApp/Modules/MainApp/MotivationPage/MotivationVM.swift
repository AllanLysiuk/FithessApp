//
//  MotivationVM.swift
//  FitnessApp
//
//  Created by Allan on 23.06.23.
//

import Foundation

final class MotivationVM: MotivationVMProtocol {
    private weak var coordinator: MotivationCoordinatorProtocol?
    
    init(coordinator: MotivationCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}
