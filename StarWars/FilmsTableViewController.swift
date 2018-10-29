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
        service.getDataWith(completion: {(result) in print(result)} )
    }
    
}
