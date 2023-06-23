//
//  HistoryVM.swift
//  FitnessApp
//
//  Created by Allan on 23.06.23.
//

import Foundation

final class HistoryVM: HistoryVMProtocol {
    private weak var coordinator: HistoryCoordinatorProtocol?
    
    init(coordinator: HistoryCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}
