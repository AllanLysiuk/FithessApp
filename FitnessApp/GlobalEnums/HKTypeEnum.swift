//
//  HKTypeEnum.swift
//  FitnessApp
//
//  Created by Allan on 7.07.23.
//

import Foundation
import HealthKit

enum HKType {
    case steps
    case distance
    case calories
    case speed
    
    func getQuantityIdentifier() -> HKQuantityTypeIdentifier {
        switch self {
        case .steps:
            return .stepCount
        case .distance:
            return .distanceWalkingRunning
        case .calories:
            return .activeEnergyBurned
        case .speed:
            return .walkingSpeed
        }
    }
    
    func getHKUnit() -> HKUnit {
        switch self {
        case .steps:
            return .count()
        case .distance:
            return .meter()
        case .calories:
            return .kilocalorie()
        case .speed:
            return .meter().unitDivided(by: .second())
        }
    }
}
