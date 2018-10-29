//
//  Species+CoreDataProperties.swift
//  StarWars
//
//  Created by Michael Meyer on 10/29/18.
//  Copyright © 2018 Michael Meyer. All rights reserved.
//
//

import Foundation
import CoreData


extension Species {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Species> {
        return NSFetchRequest<Species>(entityName: "Species")
    }

    @NSManaged public var average_height: String?
    @NSManaged public var average_lifespan: String?
    @NSManaged public var classification: String?
    @NSManaged public var designation: String?
    @NSManaged public var homeworld: String?
    @NSManaged public var language: String?
    @NSManaged public var name: String?
    @NSManaged public var url: String?

}
