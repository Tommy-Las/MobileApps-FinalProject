//
//  ItemViewCell.swift
//  Shoppy-Falcone
//
//  Created by Fallon Falcone on 11/18/22.
//

import UIKit
import Parse

class ItemViewCell: UITableViewCell {
    
    weak var viewController: UIViewController? = nil
    
    var selectedList = PFObject(className: "Lists") //<-- This needs to be near the top, with the outlets
    var items = [PFObject]()
    var item = PFObject(className:"Items")

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var brandName: UILabel! //change description to brandName
    @IBOutlet weak var quantityValue: UILabel!
    
    var indexPathRowForCell: Int = 0 //This holds a copy of the indexPath.row value, and swift demands it is initialized with a value.
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onDecrement(_ sender: Any) {
        //The following commented code crashes the app, idk how to fix it.
        /*
        guard let viewController = viewController else {
            print("No view controller found. Exiting.")
            return}
        */
        if ((Int(self.quantityValue.text! as String) ?? 0) == 1) {
                        let dialogMessage = UIAlertController(
                            title: "Delete Item",
                            message: "Are you sure you want to remove this item from your list?",
                            preferredStyle: .alert)
                            
                        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {
                            _ in
                            print("Cancel Pressed")
                         }
                        
                        let confirmAction = UIAlertAction(title: "Remove", style: .default) {
                            _ in
                            print("Remove Pressed")
                         }
                        
                        dialogMessage.addAction(cancelAction)
                        dialogMessage.addAction(confirmAction)
                        dialogMessage.preferredAction = confirmAction
                        
                        //viewController.present(dialogMessage, animated: true)
                    
                    } else {
                        var newValue = ((Int(self.quantityValue.text! as String) ?? 0) - 1) //quantityValue.text cast as an Int, then subtract it by 1.
                        self.quantityValue.text = String((Int(self.quantityValue.text! as String) ?? 0) - 1)
                        
                        let query = PFQuery(className:"Lists")
                        
                        query.includeKeys(["name", "items"])
                        query.getObjectInBackground(withId: globalObjectId) { (selectedList, error) in //use globalObjectId as the Lists table row's Id (We set this in the ListViewController swift file).
                            if error == nil {
                                self.selectedList = selectedList! // Set the found PFObject of type Lists to a variable accessible in this view controller.
                                self.items = (self.selectedList["items"] as? [PFObject]) ?? [] //Array of PFObjects (rows of Items table) that have been added to the selectedList before.
                                self.item = self.items[self.indexPathRowForCell] //An individual element of the array.
                                
                                self.item["quantity"] = String(newValue)
                                self.items[self.indexPathRowForCell] = self.item
                                self.selectedList["items"] = self.items //This adds the edited array back to the list.
                                
                                // Success!
                                
                                
                                self.selectedList.saveInBackground { (success, error) in //Does this save the item in the background?
                                    if success {
                                        print("Item saved to list successfully!")
                                        
                                    } else {
                                        print("Error saving item to list!")
                                    }
                                }

                            } else {
                                // Fail!
                            }
                        }
                    }
                }
    
    
    @IBAction func onIncrement(_ sender: Any) {
        
        if ((Int(self.quantityValue.text! as String) ?? 0) >= 1) {
            
            var newValue = ((Int(self.quantityValue.text! as String) ?? 0) + 1) //quantityValue.text cast as an Int, then sum it with 1.
            self.quantityValue.text = String((Int(self.quantityValue.text! as String) ?? 0) + 1)
            
            let query = PFQuery(className:"Lists")
            
            query.includeKeys(["name", "items"])
            query.getObjectInBackground(withId: globalObjectId) { (selectedList, error) in //use globalObjectId as the Lists table row's Id (We set this in the ListViewController swift file).
                if error == nil {
                    self.selectedList = selectedList! // Set the found PFObject of type Lists to a variable accessible in this view controller.
                    self.items = (self.selectedList["items"] as? [PFObject]) ?? [] //Array of PFObjects (rows of Items table) that have been added to the selectedList before.
                    self.item = self.items[self.indexPathRowForCell] //An individual element of the array.
                    
                    self.item["quantity"] = String(newValue)
                    self.items[self.indexPathRowForCell] = self.item
                    self.selectedList["items"] = self.items //This adds the edited array back to the list.
                    
                    // Success!
                    
    
                    
                    self.selectedList.saveInBackground { (success, error) in //Does this save the item in the background?
                        if success {
                            print("Item saved to list successfully!")
                            
                        } else {
                            print("Error saving item to list!")
                        }
                    }

                } else {
                    // Fail!
                }
            }
        }
    }
}
