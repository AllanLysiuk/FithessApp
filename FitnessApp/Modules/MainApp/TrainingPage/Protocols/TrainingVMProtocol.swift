//
//  TrainingVMProtocol.swift
//  FitnessApp
//
//  Created by Allan on 23.06.23.
//

import Foundation

protocol TrainingVMProtocol {
    func setUpDelegate(_ delegate: TrainingVCDelegate)
    func checkTimer()
    func startStopButtonDidTap()
    func resetButtonDidTap()
    func startButonDidTap(isSelected: Bool)
}
