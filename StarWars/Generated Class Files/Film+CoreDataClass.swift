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
    
    static func saveInCoreDataWith(array: [[String: AnyObject]]) {
        
        // LOOP THROUGH THE RETURNED JSON OBJECTS FROM THE API
        for dict in array {
            
            // FOR EACH JSON OBJECT, CREATE A FILM NSMANAGEDOBJECT
            // THIS CREATES AN OBJECT
            // IT ALSO STORES IT IN THE CONTEXT
             _ = self.createFilmEntityFrom(dictionary: dict)
        }
            
            // SAVE THE ENTITIES TO CORE DATA, USING THE CONTEXT
            
            do {
                try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
            }
                
            catch let error {
                print(error)
            }
        }
    }

