//
//  Film+CoreDataProperties.swift
//  StarWars
//
//  Created by Michael Meyer on 10/29/18.
//  Copyright © 2018 Michael Meyer. All rights reserved.
//
//

import Foundation
import CoreData


extension Film {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Film> {
        return NSFetchRequest<Film>(entityName: "Film")
    }

    @NSManaged public var director: String?
    @NSManaged public var episode_id: Int16
    @NSManaged public var opening_crawl: String?
    @NSManaged public var producer: String?
    @NSManaged public var release_date: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?

}
