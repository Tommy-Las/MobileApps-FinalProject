//
//  SearchedProductCell.swift
//  Shoppy
//
//  Created by Tommy on 11/22/22.
//

import UIKit
import Parse
import AlamofireImage
import Alamofire

class SearchedProductCell: UITableViewCell {

    @IBOutlet weak var productQuantity: UITextField!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    

    var imageUrlStringCell = "" //This is needed!
    var selectedList: PFObject! //<-- This needs to be near the top, with the outlets

    
    private var data = Dictionary<String, Any>()
        
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

    
    
    @IBAction func onDecrement(_ sender: Any) {
        let productQuantityAsInt = Int((productQuantity.text)!)! as Int
        if productQuantityAsInt > 0 {
            
            productQuantity.text = String(productQuantityAsInt - 1)
        }
    }
    

    
    
    @IBAction func onIncrement(_ sender: Any) {
        let productQuantityAsInt = Int((productQuantity.text)!)! as Int
        
        productQuantity.text = String(productQuantityAsInt + 1)
        
    }
    
    
    
    
    @IBAction func addProductToList(_ sender: Any) {

        //Data to be added to the list
        //var id = data["id"] as! Int
        var id = String(data["id"] as! Int)
        var classImage = UIImage(named: "itemImage")
        
        
        var name = data["title"] as! String
        var imageUrl = data["image"] as! String
        var quantity = productQuantity.text!
        
              
        let item = PFObject(className: "Items") //Create a single item row in the Items table
        item["itemId"] = id //This PFObject attribute field can not be named "id" as its a reserved word in Parse: https://github.com/parse-community/parse-server/issues/6309
        item["name"] = name
        item["imageUrlString"] = imageUrlStringCell
        item["quantity"] = quantity

        //Search for the shopping list that is considered the current one, then assign it to selectedList.
        
        let query = PFQuery(className:"Lists") //query inside Lists table
        query.includeKeys(["name", "items","numberOfItems"])
        query.getObjectInBackground(withId: globalObjectId) { (selectedList, error) in //use globalObjectId as the Lists table row's Id (We set this in the ListViewController swift file).
            if error == nil {
                self.selectedList = selectedList! // Set the found PFObject of type Lists to a variable accessible in this view controller.
                print("SearchedProductCell successfully found the list.")
                
                
                self.selectedList.incrementKey("numberOfItems")
                
                //Add the item PFObject as an element to an array, which is a (new) attribute of lists.
                self.selectedList.add(item, forKey: "items") //Just like in Parstagram, we are able to add new attributes to other tables' existing rows.
                
                //Save the item and list
                self.selectedList.saveInBackground { (success, error) in //Observation: this should save the item in background as well???
                    if success {
                        print("Item saved to list successfully!")
                        
                    } else {
                        print("Error saving item to list!")
                    }
                }
     
                // Success!
            } else {
                // Fail!
            }
        }
        
        
        
                
        //TODO: Add product to the current list in database here
    }
}
