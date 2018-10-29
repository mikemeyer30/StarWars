//
//  Film+CoreDataClass.swift
//  StarWars
//
//  Created by Michael Meyer on 10/29/18.
//  Copyright © 2018 Michael Meyer. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Film)
public class Film: NSManagedObject {
    
        static func createFilmEntityFrom(dictionary: [String: AnyObject]) -> NSManagedObject? {
    
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
    
        if let filmEntity = NSEntityDescription.insertNewObject(forEntityName: "Film", into: context) as? Film {
        
            filmEntity.title = dictionary["title"] as? String
            filmEntity.episode_id = dictionary["episode_id"] as! Int16
            //...
            //...
            //...
            return filmEntity
        }
            
        return nil
    }
}
