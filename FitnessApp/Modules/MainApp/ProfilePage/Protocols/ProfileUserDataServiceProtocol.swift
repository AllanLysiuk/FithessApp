//
//  ProfileUserDataServiceProtocol.swift
//  FitnessApp
//
//  Created by Allan on 4.07.23.
//

import Foundation

protocol ProfileUserDataServiceProtocol {
    func setIsRegisteredFlag(boolean: Bool)
    func getUserEmail() -> String 
}
