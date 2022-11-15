//
//  API.swift
//  ListApp
//
//  Created by Alexandro Galvez-Vega on 11/15/22.
//

import Foundation

struct API {
    
    static func getLists(completion: @escaping ([Restaurant]?) -> Void) {
        
        //Insert API key later
        let apikey = "_"
        
        let url = URL(string: "_")!
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoreLocalCacheData, timeoutInterval: 10)
        
        request.setValue("Bearer \(apikey)"), forHTTPHeaderField: "Authorization")
        
        let session URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                
                
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                let listInfo = dataDictionary["_"] as! [[String: Any]]
                
                //This class isn't up yet.
                
                var listInfo: [ListInfo] = []
                
                
                for dictionary in restDictionaries {
                    let info = ListInfo.init(dict: dictionary)
                    listInfo.append(info)
                }
                
                return completion(listInfo)
            }
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
