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
            newAccount.runs = []
            CoreDataStack.shared.saveContext(context: context)
        }
    }
    
    func loadAccInfoByEmail(_ email: String) -> Profile? {
        let request = Profile.fetchRequest()
        request.predicate = NSPredicate(format: "\(#keyPath(Profile.email)) == %@", email)
        request.returnsObjectsAsFaults = false
        let profile = try? CoreDataStack.shared.backgroundContext.fetch(request)
        return profile?.first
    }
    
    func updateInfoOfProfile(profileModel: ProfileModel) {
        let acc = loadAccInfoByEmail(profileModel.email)
        let context = CoreDataStack.shared.backgroundContext
        if let acc = acc {
            context.perform {
                acc.name = profileModel.name
                acc.age = Int32(profileModel.age)
                acc.gender = profileModel.gender
                acc.growth = Double(profileModel.growth)
                acc.weight = Double(profileModel.weight)
                acc.imagePath = profileModel.profileImagePath
                CoreDataStack.shared.saveContext(context: context)
            }
        }
    }
    
    func doesAccExists(with email: String) -> Bool {
        let acc = loadAccInfoByEmail(email)
        if acc != nil {
            return true
        } else {
            return false
        }
    }
}

extension CoreDataService {
    func addNewRunToProfile(profileEmail: String, run: RunModel) {
        let acc = loadAccInfoByEmail(profileEmail)
        let context = CoreDataStack.shared.backgroundContext
        if let acc = acc {
            createRun(run: run) { newRun in
                context.perform {
                    acc.addToRuns(newRun)
                    CoreDataStack.shared.saveContext(context: context)
                }
            }
        }
    }
    
    private func createRun(run: RunModel, completion: @escaping ((Run) -> Void)){
        let context = CoreDataStack.shared.backgroundContext
        context.perform {
            let newRun = Run(context: context)
            newRun.avgSpeed = run.avgSpeed
            newRun.calories = run.calories
            newRun.date = run.date
            newRun.distance = run.distance
            newRun.latitudeArr = run.latitudeArr
            newRun.longitudeArr = run.longitudeArr
            newRun.steps = run.steps
            newRun.time = run.time
            completion(newRun)
            CoreDataStack.shared.saveContext(context: context)
        }
    }
    
    func loadAccRuns(_ email: String) -> [Run]? {
        let request = Profile.fetchRequest()
        request.predicate = NSPredicate(format: "\(#keyPath(Profile.email)) == %@", email)
        request.returnsObjectsAsFaults = false
        let profiles = try? CoreDataStack.shared.backgroundContext.fetch(request)
        let acc = profiles?.first
        return acc?.runsArray
    }
    
    func deleteRun(run: Run) {
        let context = CoreDataStack.shared.backgroundContext
        context.delete(run)
        try? context.save()
    }
}
