//
//  SearchedProductCell.swift
//  Shoppy
//
//  Created by Tommy on 11/22/22.
//

import UIKit
import Parse
import AlamofireImage

class SearchedProductCell: UITableViewCell {

    @IBOutlet weak var productQuantity: UITextField!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!

    //dec 4
    //dec 5: fix the declaration
    var selectedList = PFObject(className: "Lists") //<-- This needs to be near the top, with the outlets
    //dec 5 end
    //dec 4 end
    
    private var data = Dictionary<String, Any>()
    
    @IBAction func selectCandidateItem(_ sender: Any) {
        
        //check parstagram!!!
        
        //list["Items"]  <- list of a specific data type (as opposed to a dictionary)
        
        //access the specific tableview's element (stuff returned in api call)
        //then
        
        //assign the values to values in a unique listItem attributes
        
        
        
        
        let listitem = PFObject(className: "ListItem")
        
        listitem["name"] = productName.text      // old: textField.text
        //Alex's new code below
        listitem.saveInBackground { (success, error) in
                    if success {
                        
                        startDismissing = 1
                        
                        print("saved!")
                    } else {
                        print("error!")
                    }
                }
        /*
        listitem.saveInBackground { (success, error) in
            if success{
               // self.dismiss(animated: true, completion: nil)
                print("saved!")
            } else {
                print("error!")
            }
        } */
        
        //list["Items"].append(listitem)
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(with data: Dictionary<String, Any>){
        self.data = data
    }

    @IBAction func addProductToList(_ sender: Any) {

        //Data to be added to the list
        //var id = data["id"] as! Int
        var id = String(data["id"] as! Int)
        
        var name = data["title"] as! String
        var imageUrl = data["image"] as! String
        var quantity = productQuantity.text!
        
        //DEC 4 transplant below
              
        let item = PFObject(className: "Items") //Create a single item row in the Items table
        item["itemId"] = id //Dec 5: this PFObject attribute field can not be named "id" as its a reserved word in Parse: https://github.com/parse-community/parse-server/issues/6309
        item["name"] = name
        item["imageUrl"] = imageUrl
        item["quantity"] = quantity
        //item["brandName"] = ....?
        //Dec 4: set up item["brandName"]
        

        //Search for the shopping list that is considered the current one, then assign it to selectedList.
        
        let query = PFQuery(className:"Lists") //query inside Lists table
        query.getObjectInBackground(withId: globalObjectId) { (selectedList, error) in //use globalObjectId as the Lists table row's Id (We set this in the ListViewController swift file).
            if error == nil {
                self.selectedList = selectedList! // Set the found PFObject of type Lists to a variable accessible in this view controller.
                print("SearchedProductCell successfully found the list.")
                // Success!
            } else {
                // Fail!
            }
        }
        
        //Add the item PFObject as an element to an array, which is a (new) attribute of lists.
        selectedList.add(item, forKey: "items") //Just like in Parstagram, we are able to add new attributes to other tables' existing rows.
        
        //Save the item and list
        selectedList.saveInBackground { (success, error) in //Observation: this should save the item in background as well???
            if success {
                print("Item saved to list successfully!")
                //print("\(selectedList["Items"][0]["name]"])")
            } else {
                print("Error saving item to list!")
            }
        }
        
        
        
        //DEC 4 transplant end
        
                
        //TODO: Add product to the current list in database here
    }
}
