//
//  MotivationAssembler.swift
//  FitnessApp
//
//  Created by Allan on 23.06.23.
//

import Foundation
import UIKit

final class MotivationAssembler {
    private init() { }
    
    static func makeMotivationVC(coordinator: MotivationCoordinatorProtocol) -> UIViewController {
        return MotivationVC(viewModel: makeViewModel(coordinator: coordinator))
    }
    
    private static func makeViewModel(coordinator: MotivationCoordinatorProtocol) -> MotivationVMProtocol {
        return MotivationVM(coordinator: coordinator)
    }
}
