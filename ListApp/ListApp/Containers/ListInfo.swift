//
//  ListInfo.swift
//  ListApp
//
//  Created by Alexandro Galvez-Vega on 11/15/22.
//

import Foundation

class ListInfo {
    //---Lab 2
    var imageURL: URL?
    var url: URL?
    var name: String
    var price: Double

    
    //initializzer
    init(dict: [String: Any]) {
        imageURL = URL(string: dict["_"] as! String)
        name = dict["_"] as! String
        price = dict["_"] as! Double
        url = URL(string: dict["_"] as! String)

        
        
    }

    
    
    
    
    
    
}
