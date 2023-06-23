//
//  HistoryAssembler.swift
//  FitnessApp
//
//  Created by Allan on 23.06.23.
//

import Foundation
import UIKit

final class HistoryAssembler {
    private init() { }
    
    static func makeHistoryVC(coordinator: HistoryCoordinatorProtocol) -> UIViewController {
        return HistoryVC(viewModel: makeViewModel(coordinator: coordinator))
    }
    
    private static func makeViewModel(coordinator: HistoryCoordinatorProtocol) -> HistoryVMProtocol {
        return HistoryVM(coordinator: coordinator)
    }
}
