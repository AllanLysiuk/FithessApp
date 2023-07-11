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
    
    func getStartTime() -> Date? {
        return ud.object(forKey: UserDefaultsEnum.startTime) as? Date
    }
    
    func getStopTime() -> Date? {
        return ud.object(forKey: UserDefaultsEnum.stopTime) as? Date
    }
    
    func getTimerCounting() -> Bool {
        return ud.bool(forKey: UserDefaultsEnum.timerCounting)
    }
    
    func setStartTime(startTime: Date?) {
        ud.set(startTime, forKey: UserDefaultsEnum.startTime)
    }
    
    func setStopTime(stopTime: Date?) {
        ud.set(stopTime, forKey: UserDefaultsEnum.stopTime)
    }
    
    func setTimerCounting(timerCounting: Bool) {
        ud.set(timerCounting, forKey: UserDefaultsEnum.timerCounting)
    }
    
    func  setLastLocationLatitude(latitude: [Double]?) {
        ud.set(latitude, forKey: UserDefaultsEnum.lastLocationLatitude)
    }
    
    func  getLastLocationLatitude() -> [Double]? {
        return ud.array(forKey: UserDefaultsEnum.lastLocationLatitude) as? [Double]
    }
    
    func  setLastLocationLongitude (longitude: [Double]?) {
        ud.set(longitude, forKey: UserDefaultsEnum.lastLocationLongitude)
    }
    
    func  getLastLocationLongitude() -> [Double]? {
        return ud.array(forKey: UserDefaultsEnum.lastLocationLongitude) as? [Double]
    }
    
}
