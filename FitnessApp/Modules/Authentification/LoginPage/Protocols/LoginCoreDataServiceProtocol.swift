//
//  LoginCoreDataServiceProtocol.swift
//  FitnessApp
//
//  Created by Allan on 5.07.23.
//

import Foundation

protocol LoginCoreDataServiceProtocol {
    func doesAccExists(with email: String) -> Bool
}
