//
//  Person+CoreDataClass.swift
//  StarWars
//
//  Created by Michael Meyer on 10/29/18.
//  Copyright © 2018 Michael Meyer. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Person)
public class Person: NSManagedObject {
    
        static func createPersonEntityFrom(dictionary: [String: AnyObject]) -> NSManagedObject? {
            
            let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
            
            if let personEntity = NSEntityDescription.insertNewObject(forEntityName: "Person", into: context) as? Person {
                
                personEntity.name = dictionary["name"] as? String
                personEntity.birth_year = dictionary["birth_year"] as? String
                personEntity.gender = dictionary["gender"] as? String
                personEntity.height = dictionary["height"] as? String
                personEntity.mass = dictionary["mass"] as? String
                personEntity.skin_color = dictionary["skin_color"] as? String
                personEntity.hair_color = dictionary["skin_color"] as? String
                

                return personEntity
            }
            
            return nil
    }
    
    static func saveInCoreDataWith(array: [[String: AnyObject]]) {
        
        // LOOP THROUGH THE RETURNED JSON OBJECTS FROM THE API
        for dict in array {
            
            // FOR EACH JSON OBJECT, CREATE A FILM NSMANAGEDOBJECT
            // THIS CREATES AN OBJECT
            // IT ALSO STORES IT IN THE CONTEXT
            _ = self.createPersonEntityFrom(dictionary: dict)
        }
        
        // SAVE THE ENTITIES TO CORE DATA, USING THE CONTEXT
        
        do {
            try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
        }
            
        catch let error {
            print(error)
        }
        
    }
    static func getAllPeople() -> [NSManagedObject] {
        
        // STEP 1: GET A REFERENCE TO THE CORE DATA CONTEXT
        let managedContext = CoreDataStack.sharedInstance.persistentContainer.viewContext
        
        // STEP 2: CREATE A FETCH REQUEST FOR A SPECIFIC ENTITY
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        
        // STEP 3: SORT THE OBJECTS
        let sort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        // STEP 4: CREATE A COLLECTION OF NSMANAGEDOBJECTS (Films)
        var allPeople = [NSManagedObject]()
        
        // STEP 5: Execute the fetch request
        
        do {
            
            let results = try managedContext.fetch(fetchRequest)
            //ACTUAL QUERY
            allPeople = results as! [NSManagedObject]
            
        } catch let error as NSError {
            
            print("Could not fetch people \(error), \(error.userInfo)")
            
        }
        
        // STEP 6: Return the Array
        return allPeople
    }
    
}
    
    
    

