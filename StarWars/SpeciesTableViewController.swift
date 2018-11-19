//
//  SpeciesTableViewController.swift
//  StarWars
//
//  Created by Michael Meyer on 11/12/18.
//  Copyright © 2018 Michael Meyer. All rights reserved.
//

import UIKit

class SpeciesTableViewController: UITableViewController {
    
    
    // For doing tasks before the view loads
    override func viewWillAppear(_ animated: Bool) {
        
        
        // Check to see if there is already data in core data for this entity
        if Species.getAllSpecies().count > 0 {
            return
        }
        
        // Invoke our API Service
        let service = APIService()
        service.query = "species"
        
        
        service.getDataWith(completion: {
            
            (Result) in
            
            //Check to see if we get data; if so, save it to core data
            switch (Result) {
                
            case.Success(let rawJSONAPIdata):
                Species.saveInCoreDataWith(array: rawJSONAPIdata)
            case.Error(let message):
                print(message)
                // PRINT ALL OF THE API JSON TO THE CONSOLE
                //(result) in print(result)} )
                
            }
            // CANNOT PUT THE getAllSpecies METHOD HERE.
            
            // SET OURSELF UP AS AN OBSERVER
            
            let nc = NotificationCenter.default
            nc.addObserver(forName: NSNotification.Name(rawValue: "dataUpdated"), object: nil, queue: nil) {
                notification in
                //THIS IS WHAT WE WANT TO DO WHEN WE RECIEVE THIS NOTIFICATION
                self.tableView.reloadData()
                
            }
            
            // Print the path to the DB
            CoreDataStack.sharedInstance.applicationDocumentsDirectory()
            
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Species.getAllSpecies().count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // CREATE INSTANCE OF UITableViewCell
        
        let SpeciesCell = tableView.dequeueReusableCell(withIdentifier: "speciesTableCell", for: indexPath)
        
        
        // Figure out which Species object should appear
        
        let thisSpecies = Species.getAllSpecies()[indexPath.row] as! Species
        
        // Format the cell with information from the Species object
        SpeciesCell.textLabel?.text = thisSpecies.name
        
        // Return the formatted cell
        return SpeciesCell
        
        
    }
    
    
}
