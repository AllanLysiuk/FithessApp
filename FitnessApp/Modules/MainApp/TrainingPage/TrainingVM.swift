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
    private weak var delegate: TrainingVCDelegate?
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
    
    func setUpDelegate(_ delegate: TrainingVCDelegate) {
        self.delegate = delegate
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
            delegate?.startAnimatingIndicator()
            let group = DispatchGroup()
            
            group.enter()
            healthKitService.loadInfoByType(.distance, since: startDate, to: .now) { res, error in
                if let error = error {
                    print(error.localizedDescription + "  1")
                } else {
                    self.distanceWalking = res
                }
                group.leave()
            }
            
            group.enter()
            healthKitService.loadInfoByType(.steps, since: startDate, to: .now) { res, error in
                if let error = error {
                    print(error.localizedDescription + "  2")
                } else {
                    self.steps = res
                }
                group.leave()
            }
            
            group.enter()
            healthKitService.loadInfoByType(.speed, since: startDate, to: .now) { res, error in
                if let error = error {
                    print(error.localizedDescription + "  3")
                } else {
                    self.avgSpeed = res
                }
                group.leave()
            }
            
            group.enter()
            healthKitService.loadInfoByType(.calories, since: startDate, to: .now) { res, error in
                if let error = error {
                    print(error.localizedDescription + "  4")
                } else {
                    self.calories = res
                }
                group.leave()
            }
        
            group.notify(queue: .main) {
                self.delegate?.endAnimatingIndictor(distance: self.distanceWalking, steps: self.steps, calories: self.calories, avgSpeed: self.avgSpeed)
            }
            
        }
    }

}
