//
//  TrainingVM.swift
//  FitnessApp
//
//  Created by Allan on 23.06.23.
//

import Foundation

final class TrainingVM: TrainingVMProtocol {
    
    private weak var coordinator: TrainingCoordinatorProtocol?
    private var healthKitService: TrainingHealthKitServiceProtocol
    private var startDate = Date()
    
    private var distanceWalking: Double?
    private var steps: Double?
    private var calories: Double?
    private var avgSpeed: Double?
    
    init(
        coordinator: TrainingCoordinatorProtocol,
        healthKitService: TrainingHealthKitServiceProtocol
    ) {
        self.coordinator = coordinator
        self.healthKitService = healthKitService
    }
    
    func startButonDidTap(isSelected: Bool) {
        if isSelected {
            healthKitService.authorizeHealthKit { authorized, error in
                guard authorized else {
                    let baseMessage = "HealthKit Authorization Failed"
                        
                    if let error = error {
                      print("\(baseMessage). Reason: \(error.localizedDescription)")
                    } else {
                      print(baseMessage)
                    }
                    return
                  }
            }
            startDate = .now
        } else {
            healthKitService.loadInfoByType(.distance, since: startDate, to: .now) { res, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    self.distanceWalking = res
                    print(self.distanceWalking)
                }
            }
            
            healthKitService.loadInfoByType(.steps, since: startDate, to: .now) { res, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    self.steps = res
                    print(self.steps)
                }
            }
        }
    }
    
}
