//
//  TrainingVMProtocol.swift
//  FitnessApp
//
//  Created by Allan on 23.06.23.
//

import Foundation

protocol TrainingVMProtocol {
    func setUpDelegate(_ delegate: TrainingVCDelegate)
    func startButonDidTap(isSelected: Bool)
}
