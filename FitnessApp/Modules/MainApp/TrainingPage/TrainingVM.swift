//
//  TrainingVM.swift
//  FitnessApp
//
//  Created by Allan on 23.06.23.
//

import Foundation

final class TrainingVM: TrainingVMProtocol {
    
    private weak var coordinator: TrainingCoordinatorProtocol?
    
    init(coordinator: TrainingCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    
}
