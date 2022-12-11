//
//  ItemViewCell.swift
//  Shoppy-Falcone
//
//  Created by Fallon Falcone on 11/18/22.
//

import UIKit
import Parse

class ItemViewCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var brandName: UILabel! //change description to brandName
    @IBOutlet weak var quantityValue: UILabel!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    /*
    @IBAction func onDecrement(_ sender: Any) {
        guard let viewController = viewController else {
            print("No view controller found. Exiting.")
            return}
        if value == 1 {
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
            
            viewController.present(dialogMessage, animated: true)
            
        } else {
            value = value - 1
            quantityValue.text = "\(value)"
        }
    }
    */
    
    /*
    @IBAction func onIncrement(_ sender: Any) {
        if value >= 1 {
            value = value + 1
            quantityValue.text = "\(value)"
        }
    }*/
}
    
    
    
