//
//  Planet+CoreDataClass.swift
//  StarWars
//
//  Created by Michael Meyer on 10/29/18.
//  Copyright © 2018 Michael Meyer. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Planet)
public class Planet: NSManagedObject {
    
    static func createPlanetEntityFrom(dictionary: [String: AnyObject]) -> NSManagedObject? {
        
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        
        if let planetEntity = NSEntityDescription.insertNewObject(forEntityName: "Planet", into: context) as? Planet {
            
            planetEntity.name = dictionary["name"] as? String
            planetEntity.climate = dictionary["climate"] as? String
            planetEntity.population = dictionary["population"] as? String
            planetEntity.diameter = dictionary["diameter"] as? String
            planetEntity.gravity = dictionary["gravity"] as? String
            planetEntity.orbital_period = dictionary["orbital_period"] as? String
            planetEntity.surface_water = dictionary["surface_water"] as? String
            planetEntity.rotation_period = dictionary["rotation_period"] as? String
            planetEntity.terrain = dictionary["terrain"] as? String
        
            
            
            return planetEntity
        }
        
        return nil

}
    static func saveInCoreDataWith(array: [[String: AnyObject]]) {
        
        // LOOP THROUGH THE RETURNED JSON OBJECTS FROM THE API
        for dict in array {
            
            // FOR EACH JSON OBJECT, CREATE A FILM NSMANAGEDOBJECT
            // THIS CREATES AN OBJECT
            // IT ALSO STORES IT IN THE CONTEXT
            _ = self.createPlanetEntityFrom(dictionary: dict)
        }
        
        // SAVE THE ENTITIES TO CORE DATA, USING THE CONTEXT
        
        do {
            try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
        }
            
        catch let error {
            print(error)
        }
    }
    
    static func getAllPlanets() -> [NSManagedObject] {
        
        // STEP 1: GET A REFERENCE TO THE CORE DATA CONTEXT
        let managedContext = CoreDataStack.sharedInstance.persistentContainer.viewContext
        
        // STEP 2: CREATE A FETCH REQUEST FOR A SPECIFIC ENTITY
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Planet")
        
        // STEP 3: SORT THE OBJECTS
        let sort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        // STEP 4: CREATE A COLLECTION OF NSMANAGEDOBJECTS (Films)
        var allPlanets = [NSManagedObject]()
        
        // STEP 5: Execute the fetch request
        
        do {
            
            let results = try managedContext.fetch(fetchRequest)
            //ACTUAL QUERY
            allPlanets = results as! [NSManagedObject]
            
        } catch let error as NSError {
            
            print("Could not fetch planets \(error), \(error.userInfo)")
            
            
        }
        
        
        // STEP 6: Return the Array
        return allPlanets
    }

}
