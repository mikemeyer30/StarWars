//  FilmsTableViewController.swift
//  StarWars
//  Created by Michael Meyer on 10/29/18.
//  Copyright © 2018 Michael Meyer. All rights reserved.

import UIKit

class FilmsTableViewController: UITableViewController, UISearchResultsUpdating {
    
    
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
            
            var filteredResults = Film.getAllFilms() as! [Film]
            let searchController = UISearchController(searchResultsController: nil)
    
            
            
            
                // For doing tasks before the view loads
                override func viewWillAppear(_ animated: Bool) {
                    
                    
               
                    // SET UP SEARCH CONTROLLER
                    searchController.searchResultsUpdater = self
                    searchController.dimsBackgroundDuringPresentation = false
                    definesPresentationContext = true
//                    tableView.tableHeaderView = searchController.searchBar
                    searchController.searchBar.autocapitalizationType = .none
                    navigationItem.searchController = searchController
                    
                    // Check to see if there is already data in core data for this entity
                    if Film.getAllFilms().count > 0 {
                        self.activityIndicator.stopAnimating()
                        return
                    }
                    
                    
//                    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "filmTableCell")
                    
                    
                    
                    
                    // Invoke our API Service
                    let service = APIService()
                    service.query = "films"
                    
                    
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
                                self.activityIndicator.stopAnimating()
                                self.filteredResults = Film.getAllFilms() as! [Film]
                                self.tableView.reloadData()
                                
                            }
                            
                            // Print the path to the DB
                            CoreDataStack.sharedInstance.applicationDocumentsDirectory()
                    
                })
            }
            
            override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                
                return filteredResults.count
                
            }
            
            override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
                // CREATE INSTANCE OF UITableViewCell
                
                let filmCell = tableView.dequeueReusableCell(withIdentifier: "filmTableCell", for: indexPath)
                
                
                // Figure out which film object should appear
                
                let thisFilm = filteredResults[indexPath.row] as! Film
                
                // Format the cell with information from the film object
                filmCell.textLabel?.text = thisFilm.title
                
                // Return the formatted cell
                return filmCell
                
                
            }
    
            func updateSearchResults(for searchController: UISearchController) {
                
                // RESET THE ARRAY EVERY TIME WE SEARCH
                
                    filteredResults = Film.getAllFilms() as! [Film]
                
                
                // REACT TO SEARCH INPUT
                
                if let searchText = searchController.searchBar.text, !searchText.isEmpty {
                    filteredResults = filteredResults.filter {
                        film in return (film.title?.lowercased().contains(searchText.lowercased()))!
                    }
                }
                
                // RELOAD THE TABLE DATA WITH THE FILTERED RESULTS
                
                self.tableView.reloadData()
                
                
                
            }
        }
