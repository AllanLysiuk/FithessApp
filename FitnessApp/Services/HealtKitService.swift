//
//  HealtKitService.swift
//  FitnessApp
//
//  Created by Allan on 7.07.23.
//

import Foundation
import HealthKit

final class HealthKitService: HealthKitServiceProtocol {
    
    private enum HealthKitSetUpError: Error {
        case notAvailableOnDevice
        case dataTypeNotAvailable
    }
    
    private lazy var healthStore = HKHealthStore()
    private var healthKitTypesToRead: Set<HKObjectType> = []
    
    func authorizeHealthKit(completion: @escaping (Bool, Error?) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, HealthKitSetUpError.notAvailableOnDevice)
            return
        }
        
        guard let distance = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning),
              let steps = HKQuantityType.quantityType(forIdentifier: .stepCount),
              let caloriesBurned = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned),
              let speed = HKObjectType.quantityType(forIdentifier: .walkingSpeed) else {
                  completion(false, HealthKitSetUpError.dataTypeNotAvailable)
                  return
              }
        
        healthKitTypesToRead = [distance, steps, caloriesBurned, speed]
        
        healthStore.requestAuthorization(toShare: [], read: healthKitTypesToRead) { success, error in
            completion(success, error)
        }
    }
    
    func loadInfoByType(_ type: HKType, since startTime: Date, to endTime: Date, completion: @escaping ((Double?, Error?) -> Void)) {
        guard let quantityType = HKQuantityType.quantityType(forIdentifier: type.getQuantityIdentifier()) else {
            return
        }
        let predicate = HKQuery.predicateForSamples(withStart: startTime, end: endTime, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: quantityType, quantitySamplePredicate: predicate, options: type.getHKOption()) { (_, result, error) in
            var resultCount = 0.0
            guard let result = result else {
                completion(nil, error)
                return
            }
            HKUnit.count()
            HKUnit.meter()
            HKUnit.meter().unitDivided(by: HKUnit.second())
            if let quantity = result.sumQuantity() {
                resultCount = quantity.doubleValue(for: type.getHKUnit())
            }
            DispatchQueue.main.async {
                completion(resultCount, nil)
            }
        }
        healthStore.execute(query)
    }
}
