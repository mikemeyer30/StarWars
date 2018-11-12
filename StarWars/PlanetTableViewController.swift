//
//  PlanetTableViewController.swift
//  StarWars
//
//  Created by Michael Meyer on 11/12/18.
//  Copyright © 2018 Michael Meyer. All rights reserved.
//

import UIKit

class PlanetTableViewController: UITableViewController {
    
    // For completing tasks before the view loads
    override func viewWillAppear(_ animated: Bool) {
        
        // Check to see if there is data in core data already for this entity
        if Planet.getAllPlanets().count > 0 {
            return
        }
        
        // Invoke our API Service
        let service = APIService()
        
        
        service.getDataWith(completion: {
            
            (Result) in
            
            //Check to see if we get data; if so, save it to core data
            switch (Result) {
                
            case.Success(let rawJSONAPIdata):
                Planet.saveInCoreDataWith(array: rawJSONAPIdata)
            case.Error(let message):
                print(message)
                // PRINT ALL OF THE API JSON TO THE CONSOLE
                
                print(Result)
                
            }
            
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
        
        return Planet.getAllPlanets().count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // CREATE INSTANCE OF UITableViewCell
        
        let planetCell = tableView.dequeueReusableCell(withIdentifier: "planetTableCell", for: indexPath)
        
        
        // Figure out which planet object should appear
        
        let thisPlanet = Planet.getAllPlanets()[indexPath.row] as! Planet
        
        // Format the cell with information from the planet object
        planetCell.textLabel?.text = thisPlanet.name
        
        // Return the formatted cell
        return planetCell
        
        
    }
    
}
