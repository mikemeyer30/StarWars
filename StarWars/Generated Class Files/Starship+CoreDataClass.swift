//
//  Starship+CoreDataClass.swift
//  StarWars
//
//  Created by Michael Meyer on 10/29/18.
//  Copyright © 2018 Michael Meyer. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Starship)
public class Starship: NSManagedObject {
    
    static func createStarshipEntityFrom(dictionary: [String: AnyObject]) -> NSManagedObject? {
        
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        
        if let starshipEntity = NSEntityDescription.insertNewObject(forEntityName: "Starship", into: context) as? Starship {
            
            starshipEntity.name = dictionary["name"] as? String
            starshipEntity.manufacturer = dictionary["manufactureer"] as? String
            starshipEntity.model = dictionary["model"] as? String
            starshipEntity.starship_class = dictionary["starship_class"] as? String
            starshipEntity.hyperdrive_rating = dictionary["hyperdrive_rating"] as? String
            starshipEntity.length = dictionary["length"] as? String
            starshipEntity.cost_in_credits = dictionary["cost_in_credits"] as? String
            starshipEntity.passengers = dictionary["passengers"] as? String
            starshipEntity.crew = dictionary["crew"] as? String
            return starshipEntity
        }
        
        return nil
    }
    
    static func saveInCoreDataWith(array: [[String: AnyObject]]) {
        
        // LOOP THROUGH THE RETURNED JSON OBJECTS FROM THE API
        for dict in array {
            
            // FOR EACH JSON OBJECT, CREATE A STARSHIP NSMANAGEDOBJECT
            // THIS CREATES AN OBJECT
            // IT ALSO STORES IT IN THE CONTEXT
            _ = self.createStarshipEntityFrom(dictionary: dict)
        }
        
        // SAVE THE ENTITIES TO CORE DATA, USING THE CONTEXT
        
        do {
            try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
        }
            
        catch let error {
            print(error)
        }
    }

    static func getAllStarships() -> [NSManagedObject] {
        
        // STEP 1: GET A REFERENCE TO THE CORE DATA CONTEXT
        let managedContext = CoreDataStack.sharedInstance.persistentContainer.viewContext
        
        // STEP 2: CREATE A FETCH REQUEST FOR A SPECIFIC ENTITY
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Film")
        
        // STEP 3: SORT THE OBJECTS
        let sort = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        // STEP 4: CREATE A COLLECTION OF NSMANAGEDOBJECTS (Starship)
        var allStarships = [NSManagedObject]()
        
        // STEP 5: Execute the fetch request
        
        do {
            
            let results = try managedContext.fetch(fetchRequest)
            //ACTUAL QUERY
            allStarships = results as! [NSManagedObject]
            
        } catch let error as NSError {
            
            print("Could not fetch starships \(error), \(error.userInfo)")
            
            
        }
        
        
        // STEP 6: Return the Array
        return allStarships
    }
}
