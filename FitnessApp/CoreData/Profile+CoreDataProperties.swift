//
//  Profile+CoreDataProperties.swift
//  FitnessApp
//
//  Created by Allan on 4.07.23.
//
//

import Foundation
import CoreData


extension Profile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profile> {
        return NSFetchRequest<Profile>(entityName: "Profile")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int32
    @NSManaged public var weight: Double
    @NSManaged public var growth: Double
    @NSManaged public var imagePath: String?
    @NSManaged public var gender: String?
    @NSManaged public var email: String?

}

extension Profile : Identifiable {

}
