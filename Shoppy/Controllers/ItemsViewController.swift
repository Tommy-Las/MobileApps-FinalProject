//
//  ItemsViewController.swift
//  Shoppy-Falcone
//
//  Created by Fallon Falcone on 11/17/22.
//

import UIKit
import Parse

class ItemsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    // December 4 code, Oliver's transplant
    var selectedList = PFObject(className: "Lists") //<-- This needs to be near the top, with the outlets
    // December 4 code end
    
    
    @IBOutlet weak var itemTableView: UITableView!
    
    var name2 = ""
    var foodSearch = [[String: Any]]()
    var items = [PFObject]() //Dec 5 new variable initialization so it is accessible in viewdidload and tableview cell.
    //^ This was fixed (it was being unwrapped previously for some odd reason
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Dec 5 beginning
        //We need to do a query for the list that matches the globalObjectId so that we can access it to retrieve the items (The list is assigned to selectedList)
        let query = PFQuery(className:"Lists") //query inside Lists table
        query.getObjectInBackground(withId: globalObjectId) { (selectedList, error) in //use globalObjectId as the Lists table row's Id (We set this in the ListViewController swift file).
            if error == nil {
                self.selectedList = selectedList! // Set the found PFObject of type Lists to a variable accessible in this view controller.
                //self.tableView.reloadData()
                // Success!
                print("List with globalObjectId was found in ItemsViewController. The global id is \(globalObjectId)")
            } else {
                // Fail!
            }
        }
        
        self.items = (self.selectedList["items"] as? [PFObject]) ?? [] //Array of PFObjects (rows of Items table) that have been added to the selectedList before.
        //print("Testing of printing: \(items[0]["name"])")
        
       
        
        itemTableView.dataSource = self
        itemTableView.delegate = self
        navigationItem.title = "\(name2)"
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated) //THIS IS NEEDED
        
        //Dec 5 beginning
        //We need to do a query for the list that matches the globalObjectId so that we can access it to retrieve the items (The list is assigned to selectedList)
        let query = PFQuery(className:"Lists") //query inside Lists table
        query.getObjectInBackground(withId: globalObjectId) { (selectedList, error) in //use globalObjectId as the Lists table row's Id (We set this in the ListViewController swift file).
            if error == nil {
                self.selectedList = selectedList! // Set the found PFObject of type Lists to a variable accessible in this view controller.
                //self.tableView.reloadData()
                // Success!
                print("List with globalObjectId was found in ItemsViewController. The global id is \(globalObjectId)")
            } else {
                // Fail!
            }
        }
        
        self.items = (self.selectedList["items"] as? [PFObject]) ?? [] //Array of PFObjects (rows of Items table) that have been added to the selectedList before.
        //print("Testing of printing: \(items[0]["name"])")
        
        self.itemTableView.reloadData()
        
        //Dec 5 end
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
        //return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // December 4 code, Oliver's transplant
        
        
        //Former place of a query to assign selectedList
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemViewCell") as! ItemViewCell //item cell
        

        
        //Former place of items being assigned selectedList's items array.
        
        let item = items[indexPath.row] //An individual element of that array. indexPath.row is the Nth table cell, and we need the Nth item of the selectedList.
        
        cell.itemName.text = item["name"] as! String //Access an attribute of that array element
        print("Printing item[name] value inside cell.........\(item["name"])")
        //cell.brandName.text = item["brandName"] as! String //Access an attribute of that array element //Dec 4: This has to be set up later???
        cell.quantityValue.text = item["quantity"] as! String //Access an attribute of that array element
        // cell.imageUrl = item["imageUrl"] as! String
        //^ Must add a cell variable for the image later.

        
        return cell
        //December 4 code end
        
        //Old code below (pre December 4)
        //let cell = tableView.dequeueReusableCell(withIdentifier: "ItemViewCell") as! ItemViewCell
        //cell.viewController = self
        //return cell
        //Old code above (pre December 4)
    }
    
    
    
    @IBAction func logoutAccount(_ sender: Any) {
        
        //PFUser.logout()
        
        let main = UIStoryboard(name : "Main", bundle: nil)
        
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else { return }
        
        
        delegate.window?.rootViewController = loginViewController
        
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
