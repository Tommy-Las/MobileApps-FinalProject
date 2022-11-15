//
//  ItemCell.swift
//  ListApp
//
//  Created by Tommy on 11/15/22.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var removeItem: UIButton!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onRemoveItem(_ sender: Any) {
    }
    

}
