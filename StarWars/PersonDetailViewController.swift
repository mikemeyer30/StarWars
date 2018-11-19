//
//  PersonDetailViewController.swift
//  StarWars
//
//  Created by Michael Meyer on 11/19/18.
//  Copyright © 2018 Michael Meyer. All rights reserved.
//

import Foundation
import UIKit

class PersonDetailViewController: UIViewController {
    
    var selectedPerson: Person!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblBirthYear: UILabel!
    @IBOutlet weak var lblHeight: UILabel!
    @IBOutlet weak var lblSkinColor: UILabel!
    @IBOutlet weak var lblMass: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblHairColor: UILabel!
    @IBOutlet weak var lblEyeColor: UILabel!
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        lblName.text = selectedPerson.name
        lblBirthYear.text = selectedPerson.birth_year
        lblHeight.text = selectedPerson.height
        lblSkinColor.text = selectedPerson.skin_color
        lblMass.text = selectedPerson.mass
        lblGender.text = selectedPerson.gender
        lblHairColor.text = selectedPerson.hair_color
        lblEyeColor.text = selectedPerson.eye_color
        
    }
    
}





