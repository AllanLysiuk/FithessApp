//
//  TrainingCoreDataServiceProtocol.swift
//  FitnessApp
//
//  Created by Аллан Лысюк on 14.07.23.
//

import Foundation

protocol TrainingCoreDataServiceProtocol {
    func addNewRunToProfile(profileEmail: String, run: RunModel)
    func loadAccRuns(_ email: String) -> [Run]? 
}
