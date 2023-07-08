//
//  TrainingVCDelegate.swift
//  FitnessApp
//
//  Created by Allan on 8.07.23.
//

import Foundation

protocol TrainingVCDelegate: AnyObject {
    func startAnimatingIndicator()
    func endAnimatingIndictor(distance: Double?, steps: Double?, calories: Double?, avgSpeed: Double?)
}
