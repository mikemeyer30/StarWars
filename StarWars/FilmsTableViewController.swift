//  FilmsTableViewController.swift
//  StarWars
//  Created by Michael Meyer on 10/29/18.
//  Copyright © 2018 Michael Meyer. All rights reserved.

import UIKit

class FilmsTableViewController: UITableViewController {
    
    // For doing tasks before the view loads
    override func viewWillAppear(_ animated: Bool) {
        
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
            
            
            CoreDataStack.sharedInstance.applicationDocumentsDirectory()
    
})
}
}
