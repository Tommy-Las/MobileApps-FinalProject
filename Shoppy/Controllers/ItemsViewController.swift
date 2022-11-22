//
//  ItemsViewController.swift
//  Shoppy-Falcone
//
//  Created by Fallon Falcone on 11/17/22.
//

import UIKit
import Parse

class ItemsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var itemTableView: UITableView!
    
    var name = ""
    var foodSearch = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemTableView.dataSource = self
        itemTableView.delegate = self
        navigationItem.title = "\(name)"
        
        self.itemTableView.reloadData()
        
        let url = URL(string: "https://api.nal.usda.gov/fdc/v1/foods/search?api_key=eplF2FxeKwU1y4OTCOEGGkFOWZIJDefYtadhtXoK")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                 
//                 self.foodSearch = dataDictionary["results"] as! [[String: Any]]
             }
        }
        task.resume()
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemViewCell") as! ItemViewCell
        cell.viewController = self
        return cell
    }
    
    
    

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
