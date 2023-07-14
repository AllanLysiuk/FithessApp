//
//  Profile+CoreDataProperties.swift
//  FitnessApp
//
//  Created by Аллан Лысюк on 14.07.23.
//
//

import Foundation
import CoreData


extension Profile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profile> {
        return NSFetchRequest<Profile>(entityName: "Profile")
    }

    @NSManaged public var age: Int32
    @NSManaged public var email: String?
    @NSManaged public var gender: String?
    @NSManaged public var growth: Double
    @NSManaged public var imagePath: String?
    @NSManaged public var name: String?
    @NSManaged public var weight: Double
    @NSManaged public var runs: NSSet?

    
    public var runsArray: [Run] {
        let set = runs as? Set<Run> ?? []
        return set.sorted {
            $0.unwrappedDate < $1.unwrappedDate
        }
    }
}

// MARK: Generated accessors for runs
extension Profile {

    @objc(addRunsObject:)
    @NSManaged public func addToRuns(_ value: Run)

    @objc(removeRunsObject:)
    @NSManaged public func removeFromRuns(_ value: Run)

    @objc(addRuns:)
    @NSManaged public func addToRuns(_ values: NSSet)

    @objc(removeRuns:)
    @NSManaged public func removeFromRuns(_ values: NSSet)

}

extension Profile : Identifiable {

}
