//
//  PersonTableViewController.swift
//  StarWars
//
//  Created by Michael Meyer on 11/12/18.
//  Copyright © 2018 Michael Meyer. All rights reserved.
//

import UIKit

class PersonTableViewController: UITableViewController {
    
        // For completing tasks before the view loads
        override func viewWillAppear(_ animated: Bool) {
            
            // Check to see if there is data in core data already for this entity
            if Person.getAllPeople().count > 0 {
                return
            }
            
            // Invoke our API Service
            let service = APIService()
            service.query = "people"
            
            
            service.getDataWith(completion: {
                
                (Result) in
                
                //Check to see if we get data; if so, save it to core data
                switch (Result) {
                    
                    
                case.Success(let rawJSONAPIdata):
                    Person.saveInCoreDataWith(array: rawJSONAPIdata)
                    print(rawJSONAPIdata)
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
        
            return Person.getAllPeople().count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // CREATE INSTANCE OF UITableViewCell
        
        let personCell = tableView.dequeueReusableCell(withIdentifier: "personTableCell", for: indexPath)
        
        
        // Figure out which person object should appear
        
        let thisPerson = Person.getAllPeople()[indexPath.row] as! Person
        
        // Format the cell with information from the person object
        personCell.textLabel?.text = thisPerson.name
        
        // Return the formatted cell
        return personCell
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "PersonDetailView" {
            
            let PersonDetailView = segue.destination as! PersonDetailViewController
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let selectedPerson = Person.getAllPeople()[indexPath.row]
                
            PersonDetailView.selectedPerson = selectedPerson as! Person
                
            }
            
        }
        
    }
}
