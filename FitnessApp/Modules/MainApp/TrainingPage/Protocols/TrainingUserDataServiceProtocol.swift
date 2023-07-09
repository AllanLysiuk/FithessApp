//
//  TrainingUserDataServiceProtocol.swift
//  FitnessApp
//
//  Created by Allan on 9.07.23.
//

import Foundation

protocol TrainingUserDataServiceProtocol {
    func getStartTime() -> Date?
    func getStopTime() -> Date?
    func getTimerCounting() -> Bool
    
    func setStartTime(startTime: Date?)
    func setStopTime(stopTime: Date?)
    func setTimerCounting(timerCounting: Bool)
}
