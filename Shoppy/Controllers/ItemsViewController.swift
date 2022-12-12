//
//  ItemsViewController.swift
//  Shoppy-Falcone
//
//  Created by Fallon Falcone on 11/17/22.
//

import UIKit
import Parse

class ItemsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    var selectedList = PFObject(className: "Lists") //<-- This needs to be near the top, with the outlets
    var itemCount = 0
    
    @IBOutlet weak var itemTableView: UITableView!
    
    var listName = ""
    var foodSearch = [[String: Any]]()
    var items = [PFObject]()
    
    @IBAction func returnToLists(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "" //Needed!
        
  
        itemTableView.dataSource = self
        itemTableView.delegate = self
        
        let query = PFQuery(className:"Lists")
        
        query.includeKeys(["name", "items"])
        query.getObjectInBackground(withId: globalObjectId) { (selectedList, error) in //use globalObjectId as the Lists table row's Id (We set this in the ListViewController swift file).
            if error == nil {
                self.selectedList = selectedList! // Set the found PFObject of type Lists to a variable accessible in this view controller.
                self.items = (self.selectedList["items"] as? [PFObject]) ?? [] //Array of PFObjects (rows of Items table) that have been added to the selectedList before.

                
                self.listName = (self.selectedList["name"] as? String)!
                self.navigationItem.title = "List \"\(self.listName)\". # of items: \(self.selectedList["numberOfItems"]!)"
                self.itemCount = (self.selectedList["numberOfItems"]! as? Int)!
                self.itemTableView.reloadData()
            } else {
                // Fail!
            }
        }
        
        //Old API access below
        /*
        let url = URL(string: "https://api.nal.usda.gov/fdc/v1/foods/search?api_key=eplF2FxeKwU1y4OTCOEGGkFOWZIJDefYtadhtXoK")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                 
                 self.foodSearch = dataDictionary["results"] as! [[String: Any]]
             }
        }
         task.resume()
         */
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let query = PFQuery(className:"Lists")
        
        query.includeKeys(["name", "items"])
        query.getObjectInBackground(withId: globalObjectId) { (selectedList, error) in //use globalObjectId as the Lists table row's Id (We set this in the ListViewController swift file).
            if error == nil {
                self.selectedList = selectedList! // Set the found PFObject of type Lists to a variable accessible in this view controller.
                self.items = (self.selectedList["items"] as? [PFObject]) ?? [] //Array of PFObjects (rows of Items table) that have been added to the selectedList before.
                
                
                self.itemCount = (self.selectedList["numberOfItems"]! as? Int)!
                self.itemTableView.reloadData()
                // Success!
                
                self.navigationItem.title = "List \"\(self.listName)\". # of items: \(self.selectedList["numberOfItems"]!)"
            } else {
                // Fail!
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let query = PFQuery(className:"Lists")
        
        query.includeKeys(["name", "items"])
        query.getObjectInBackground(withId: globalObjectId) { (selectedList, error) in //use globalObjectId as the Lists table row's Id (We set this in the ListViewController swift file).
            if error == nil {
                self.selectedList = selectedList! // Set the found PFObject of type Lists to a variable accessible in this view controller.
                self.items = (self.selectedList["items"] as? [PFObject]) ?? [] //Array of PFObjects (rows of Items table) that have been added to the selectedList before.
                
                // Success!

            } else {
                // Fail!
            }
        }

        return itemCount

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemViewCell") as! ItemViewCell //item cell
        
        
        let query = PFQuery(className:"Lists")
        
        query.includeKeys(["name", "items"])
        query.getObjectInBackground(withId: globalObjectId) { (selectedList, error) in //use globalObjectId as the Lists table row's Id (We set this in the ListViewController swift file).
            if error == nil {
                self.selectedList = selectedList! // Set the found PFObject of type Lists to a variable accessible in this view controller.
                self.items = (self.selectedList["items"] as? [PFObject]) ?? [] //Array of PFObjects (rows of Items table) that have been added to the selectedList before.
                
                // Success!

            } else {
                // Fail!
            }
        }
        
        let item = items[indexPath.row] //An individual element of the array.
        
        cell.itemName.text = item["name"] as! String //Access an attribute of that array element
        cell.indexPathRowForCell = indexPath.row
    
        let imageString = item["imageUrlString"] as! String
        let imageURL = URL(string: imageString)!
        cell.productImage.af.setImage(withURL: imageURL)

        
        
        cell.quantityValue.text = item["quantity"] as! String
     
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            //The following 3 lines of code from ListViewController were used to write the code in this function:
            
            //self.lists[indexPath.row].deleteInBackground()    //delete row of lists table
            //self.lists.remove(at: indexPath.row) //remove array element at Nth position
            //tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            
           
            let query = PFQuery(className:"Lists") //query inside Lists table
            
            query.includeKeys(["name", "items"])
            query.getObjectInBackground(withId: globalObjectId) { (selectedList, error) in //use globalObjectId as the Lists table row's Id (We set this in the ListViewController swift file).
                if error == nil {
                    self.selectedList = selectedList! // Set the found PFObject of type Lists to a variable accessible in this view controller.
                    self.items = (self.selectedList["items"] as? [PFObject]) ?? [] //Array of PFObjects (rows of Items table) that have been added to the selectedList before.
                    
                    // Success!
     
                } else {
                    // Fail!
                }
            }
            self.itemCount = self.itemCount - 1
            let item = self.items[indexPath.row]
            
            self.selectedList["numberOfItems"] = (self.selectedList["numberOfItems"]! as? Int)! - 1
            
            item.deleteInBackground()
            self.items.remove(at: indexPath.row)

            self.selectedList["items"] = self.items
            
            self.selectedList.saveInBackground { (success, error) in
                if success {
                    print("Item saved to list successfully!")
                    
                } else {
                    print("Error saving item to list!")
                }
            }
            
            
            
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            
            self.viewDidAppear(true)
            
            //decrement the variable that controls row count
            
            
     
        }
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
