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
    
        static func getAllFilms() -> [NSManagedObject] {
            
            // STEP 1: GET A REFERENCE TO THE CORE DATA CONTEXT
            let managedContext = CoreDataStack.sharedInstance.persistentContainer.viewContext
            
            // STEP 2: CREATE A FETCH REQUEST FOR A SPECIFIC ENTITY
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Film")
            
            // STEP 3: SORT THE OBJECTS
            let sort = NSSortDescriptor(key: "title", ascending: true)
            fetchRequest.sortDescriptors = [sort]
            
            // STEP 4: CREATE A COLLECTION OF NSMANAGEDOBJECTS (Films)
            var allFilms = [NSManagedObject]()
            
            // STEP 5: Execute the fetch request
            
            do {
                
                let results = try managedContext.fetch(fetchRequest)
                //ACTUAL QUERY
                allFilms = results as! [NSManagedObject]
                
            } catch let error as NSError {
                
                print("Could not fetch films \(error), \(error.userInfo)")
                
                
            }
            
            
            // STEP 6: Return the Array
            return allFilms
        }
    
    }

