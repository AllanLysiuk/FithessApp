//
//  TrainingHealthKitServiceProtocol.swift
//  FitnessApp
//
//  Created by Allan on 7.07.23.
//

import Foundation

protocol TrainingHealthKitServiceProtocol {
    func authorizeHealthKit(completion: @escaping (Bool, Error?) -> Void)
    func loadInfoByType(_ type: HKType, since startTime: Date, to endTime: Date, completion: @escaping ((Double?, Error?) -> Void))
}
