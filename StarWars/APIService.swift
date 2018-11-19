//
//  APIService.swift
//  StarWars
//
//  Created by Michael Meyer on 10/24/18.
//  Copyright © 2018 Michael Meyer. All rights reserved.
//

import Foundation

enum Result <T> {
    case Success(T)
    case Error(String)
}

class APIService: NSObject {
    
//    let query = "films"
    var query = String()
    lazy var endPoint: String = {
        return "https://swapi.co/api/\(self.query)"
    }()
    
    func getDataWith(completion: @escaping ( Result<[[String: AnyObject]]>) -> Void) {
        
        guard let url = URL(string: endPoint) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [String: AnyObject] {
                    
                    guard let itemsJsonArray = json["results"] as? [[String: AnyObject]] else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        completion(.Success(itemsJsonArray))
                        
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name(rawValue: "Dataupdated"), object: nil)
                    }
                    
                    
                } else {
                    return
                }
                
            } catch let error {
                print(error)
            }
            
            }.resume()
        
    }

    
}
