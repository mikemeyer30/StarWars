//
//  Species+CoreDataClass.swift
//  StarWars
//
//  Created by Michael Meyer on 10/29/18.
//  Copyright © 2018 Michael Meyer. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Species)
public class Species: NSManagedObject {
    
    static func createSpeciesEntityFrom(dictionary: [String: AnyObject]) -> NSManagedObject? {
        
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        
        if let speciesEntity = NSEntityDescription.insertNewObject(forEntityName: "Species", into: context) as? Species {
            
            speciesEntity.name = dictionary["name"] as? String
            speciesEntity.homeworld = dictionary["homeworld"] as? String
            speciesEntity.classification = dictionary["classification"] as? String
            speciesEntity.designation = dictionary["designation"] as? String
            speciesEntity.language = dictionary["language"] as? String
            speciesEntity.average_height = dictionary["average_height"] as? String
            speciesEntity.average_lifespan = dictionary["average_lifespan"] as? String
            
            return speciesEntity
        }
        
        return nil
    }
    
    static func saveInCoreDataWith(array: [[String: AnyObject]]) {
        
        // LOOP THROUGH THE RETURNED JSON OBJECTS FROM THE API
        for dict in array {
            
            // FOR EACH JSON OBJECT, CREATE A Species NSMANAGEDOBJECT
            // THIS CREATES AN OBJECT
            // IT ALSO STORES IT IN THE CONTEXT
            _ = self.createSpeciesEntityFrom(dictionary: dict)
        }
        
        // SAVE THE ENTITIES TO CORE DATA, USING THE CONTEXT
        
        do {
            try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
        }
            
        catch let error {
            print(error)
        }
    }
    
    static func getAllSpecies() -> [NSManagedObject] {
        
        // STEP 1: GET A REFERENCE TO THE CORE DATA CONTEXT
        let managedContext = CoreDataStack.sharedInstance.persistentContainer.viewContext
        
        // STEP 2: CREATE A FETCH REQUEST FOR A SPECIFIC ENTITY
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Species")
        
        // STEP 3: SORT THE OBJECTS
        let sort = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        // STEP 4: CREATE A COLLECTION OF NSMANAGEDOBJECTS (Species)
        var allSpecies = [NSManagedObject]()
        
        // STEP 5: Execute the fetch request
        
        do {
            
            let results = try managedContext.fetch(fetchRequest)
            //ACTUAL QUERY
            allSpecies = results as! [NSManagedObject]
            
        } catch let error as NSError {
            
            print("Could not fetch Species \(error), \(error.userInfo)")
            
            
        }
        
        
        // STEP 6: Return the Array
        return allSpecies
    }

}
