//
//  Planet+CoreDataProperties.swift
//  StarWars
//
//  Created by Michael Meyer on 10/29/18.
//  Copyright © 2018 Michael Meyer. All rights reserved.
//
//

import Foundation
import CoreData


extension Planet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Planet> {
        return NSFetchRequest<Planet>(entityName: "Planet")
    }

    @NSManaged public var climate: String?
    @NSManaged public var diameter: String?
    @NSManaged public var gravity: String?
    @NSManaged public var name: String?
    @NSManaged public var orbital_period: String?
    @NSManaged public var population: String?
    @NSManaged public var rotation_period: String?
    @NSManaged public var surface_water: String?
    @NSManaged public var terrain: String?
    @NSManaged public var url: String?

}
