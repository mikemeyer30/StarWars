//  FilmsTableViewController.swift
//  StarWars
//  Created by Michael Meyer on 10/29/18.
//  Copyright © 2018 Michael Meyer. All rights reserved.

import UIKit

        class FilmsTableViewController: UITableViewController {
            
                // For doing tasks before the view loads
                override func viewWillAppear(_ animated: Bool) {
                    
                    
                    // Check to see if there is already data in core data for this entity
                    if Film.getAllFilms().count > 0 {
                        return
                    }
                    
                    // Invoke our API Service
                    let service = APIService()
                    
                    
                        service.getDataWith(completion: {
                            
                            (Result) in
                            
                            //Check to see if we get data; if so, save it to core data
                            switch (Result) {
                                
                            case.Success(let rawJSONAPIdata):
                                Film.saveInCoreDataWith(array: rawJSONAPIdata)
                            case.Error(let message):
                                print(message)
                            // PRINT ALL OF THE API JSON TO THE CONSOLE
                            //(result) in print(result)} )
                        
                    }
                            // CANNOT PUT THE getAllFilms METHOD HERE.
                            
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
                
                return Film.getAllFilms().count
                
            }
            
            override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
                // CREATE INSTANCE OF UITableViewCell
                
                let filmCell = tableView.dequeueReusableCell(withIdentifier: "filmTableCell", for: indexPath)
                
                
                // Figure out which film object should appear
                
                let thisFilm = Film.getAllFilms()[indexPath.row] as! Film
                
                // Format the cell with information from the film object
                filmCell.textLabel?.text = thisFilm.title
                
                // Return the formatted cell
                return filmCell
                
                
            }
        }
