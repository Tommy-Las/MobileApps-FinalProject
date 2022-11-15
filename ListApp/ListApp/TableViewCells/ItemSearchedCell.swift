//
//  ItemSearchedCell.swift
//  ListApp
//
//  Created by Tommy on 11/15/22.
//

import UIKit

class ItemSearchedCell: UITableViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemQuantity: UITextField!
    @IBOutlet weak var itemName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func AddItem(_ sender: Any) {
    }
    
}
