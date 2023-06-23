//
//  TrainingAssembler.swift
//  FitnessApp
//
//  Created by Allan on 23.06.23.
//

import Foundation
import UIKit

final class TrainingAssembler {
    private init() { }
    
    static func makeTrainingVC(coordinator: TrainingCoordinatorProtocol) -> UIViewController {
        return TrainingVC(viewModel: makeViewModel(coordinator: coordinator))
    }
    
    private static func makeViewModel(coordinator: TrainingCoordinatorProtocol) -> TrainingVMProtocol {
        return TrainingVM(coordinator: coordinator)
    }
}
