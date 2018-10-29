//
//  Person+CoreDataProperties.swift
//  StarWars
//
//  Created by Michael Meyer on 10/29/18.
//  Copyright © 2018 Michael Meyer. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var birth_year: String?
    @NSManaged public var eye_color: String?
    @NSManaged public var gender: String?
    @NSManaged public var hair_color: String?
    @NSManaged public var height: String?
    @NSManaged public var mass: String?
    @NSManaged public var name: String?
    @NSManaged public var skin_color: String?
    @NSManaged public var url: String?

}
