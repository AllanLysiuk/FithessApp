//
//  Run+CoreDataProperties.swift
//  FitnessApp
//
//  Created by Аллан Лысюк on 14.07.23.
//
//

import Foundation
import CoreData


extension Run {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Run> {
        return NSFetchRequest<Run>(entityName: "Run")
    }

    @NSManaged public var time: String?
    @NSManaged public var distance: Double
    @NSManaged public var steps: Int64
    @NSManaged public var calories: Double
    @NSManaged public var avgSpeed: Double
    @NSManaged public var latitudeArr: [Double]?
    @NSManaged public var longitudeArr: [Double]?
    @NSManaged public var date: Date?
    @NSManaged public var profile: Profile?
    
    public var unwrappedDate: Date {
        date ?? Date()
    }

}

extension Run : Identifiable {

}
