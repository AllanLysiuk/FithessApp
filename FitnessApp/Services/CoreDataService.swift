//
//  CoreDataService.swift
//  FitnessApp
//
//  Created by Allan on 4.07.23.
//

import Foundation

final class CoreDataService: CoreDataServiceProtocol {
    
    func addNewAccount(profileModel: ProfileModel) {
        let context = CoreDataStack.shared.backgroundContext
        context.perform {
           let newAccount = Profile(context: context)
            newAccount.name = profileModel.name
            newAccount.age = Int32(profileModel.age)
            newAccount.gender = profileModel.gender
            newAccount.growth = Double(profileModel.growth)
            newAccount.weight = Double(profileModel.weight)
            newAccount.imagePath = profileModel.profileImagePath
            newAccount.email = profileModel.email
            CoreDataStack.shared.saveContext(context: context)
        }
    }
    
    func loadAccInfoByEmail(_ email: String) -> Profile {
        let request = Profile.fetchRequest()
        request.predicate = NSPredicate(format: "\(#keyPath(Profile.email)) == %@", email)
        request.returnsObjectsAsFaults = false
        let profile = try? CoreDataStack.shared.backgroundContext.fetch(request)
        return profile?.first ?? Profile()
    }
    
    func updateInfoOfProfile(profileModel: ProfileModel) {
        let acc = loadAccInfoByEmail(profileModel.email)
        
        let context = CoreDataStack.shared.backgroundContext
        context.perform {
            acc.name = profileModel.name
            acc.age = Int32(profileModel.age)
            acc.gender = profileModel.gender
            acc.growth = Double(profileModel.growth)
            acc.weight = Double(profileModel.weight)
            acc.imagePath = profileModel.profileImagePath
            acc.email = profileModel.email
            CoreDataStack.shared.saveContext(context: context)
        }
    }
}
