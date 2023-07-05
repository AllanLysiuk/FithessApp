//
//  LoginUserDataServiceProtocol.swift
//  FitnessApp
//
//  Created by Allan on 29.06.23.
//

import Foundation

protocol LoginUserDataServiceProtocol {
    func setOnBoardingFlag(boolean: Bool)
    func setIsRegisteredFlag(boolean: Bool)
    func saveUserEmail(email: String)
}
