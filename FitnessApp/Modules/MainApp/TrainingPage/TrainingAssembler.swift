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
    
    static func makeTrainingVC(coordinator: TrainingCoordinatorProtocol, container: Container) -> UIViewController {
        return TrainingVC(viewModel: makeViewModel(coordinator: coordinator, container: container))
    }
    
    private static func makeViewModel(coordinator: TrainingCoordinatorProtocol,container: Container) -> TrainingVMProtocol {
        return TrainingVM(coordinator: coordinator, healthKitService: makeHeakthKitService(container: container), userDataService: makeUserDataService(container: container))
    }
    
    private static func makeHeakthKitService(container: Container) -> HealthKitServiceProtocol {
        return container.resolve()
    }
    
    private static func makeUserDataService(container: Container) -> UserDataServiceProtocol {
        return container.resolve()
    }
}
