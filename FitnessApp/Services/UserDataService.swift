//
//  UserDataService.swift
//  FitnessApp
//
//  Created by Allan on 29.06.23.
//

import Foundation

final class UserDataService: UserDataServiceProtocol {
    
    private lazy var ud: UserDefaults = {
       return UserDefaults()
    }()
    
    func setIsRegisteredFlag(boolean: Bool) {
        ud.set(boolean, forKey: UserDefaultsEnum.isRegistered)
    }
    
    func setOnBoardingFlag(boolean: Bool) {
        ud.set(boolean, forKey: UserDefaultsEnum.onBoardingShowed)
    }

    func saveUserEmail(email: String) {
        ud.set(email, forKey: UserDefaultsEnum.currentUserEmail)
    }
    
    func getUserEmail() -> String {
       return ud.string(forKey: UserDefaultsEnum.currentUserEmail) ?? ""
    }
}
