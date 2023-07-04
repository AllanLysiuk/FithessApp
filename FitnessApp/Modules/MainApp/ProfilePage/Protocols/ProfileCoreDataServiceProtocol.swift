//
//  ProfileCoreDataServiceProtocol.swift
//  FitnessApp
//
//  Created by Allan on 4.07.23.
//

import Foundation

protocol ProfileCoreDataServiceProtocol {
    func loadAccInfoByEmail(_ email: String) -> Profile
    func updateInfoOfProfile(profileModel: ProfileModel)
}
