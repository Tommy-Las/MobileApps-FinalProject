//
//  SearchedProductCell.swift
//  Shoppy
//
//  Created by Tommy on 11/22/22.
//

import UIKit

class SearchedProductCell: UITableViewCell {

    @IBOutlet weak var productQuantity: UITextField!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!

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

    @IBAction func addProductToList(_ sender: Any) {

        //Data to be added to the list
        var id = data["id"] as! Int
        var name = data["title"] as! String
        var imageUrl = data["image"] as! String
        var quantity = productQuantity.text!
                
        //TODO: Add product to the current list in database here
    }
}
