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

    private var data = Dictionary<String, Any>()
    
    @IBAction func selectCandidateItem(_ sender: Any) {
        
        //check parstagram!!!
        
        //list["items"]  <- list of a specific data type (as opposed to a dictionary)
        
        //access the specific tableview's element (stuff returned in api call)
        //then
        
        //assign the values to values in a unique listItem attributes
        
        
        
        
        let listitem = PFObject(className: "ListItem")
        
        listitem["name"] = productName.text      // old: textField.text
        //Alex's new code below
        listitem.saveInBackground { (success, error) in
                    if success {
                        
                        startDismissing = 1
                        self.dismiss(animated: true, completion: nil)
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
        
        //list["items"].append(listitem)
        
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
        var id = data["id"] as! Int
        var name = data["title"] as! String
        var imageUrl = data["image"] as! String
        var quantity = productQuantity.text!
                
        //TODO: Add product to the current list in database here
    }
}
