//
//  ViewController.swift
//  StarWars
//
//  Created by Michael Meyer on 10/24/18.
//  Copyright © 2018 Michael Meyer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
        // For doing tasks before the view loads
    override func viewWillAppear(_ animated: Bool) {
        
        // Invoke our API Service
        let service = APIService()
        service.getDataWith(completion: {(result) in print(result)} )
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

