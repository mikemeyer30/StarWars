//
//  Starship+CoreDataProperties.swift
//  StarWars
//
//  Created by Michael Meyer on 10/29/18.
//  Copyright © 2018 Michael Meyer. All rights reserved.
//
//

import Foundation
import CoreData


extension Starship {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Starship> {
        return NSFetchRequest<Starship>(entityName: "Starship")
    }

    @NSManaged public var cost_in_credits: String?
    @NSManaged public var crew: String?
    @NSManaged public var hyperdrive_rating: String?
    @NSManaged public var length: String?
    @NSManaged public var manufacturer: String?
    @NSManaged public var model: String?
    @NSManaged public var name: String?
    @NSManaged public var passengers: String?
    @NSManaged public var starship_class: String?
    @NSManaged public var url: String?

}
