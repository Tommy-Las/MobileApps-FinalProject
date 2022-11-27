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
    @IBOutlet weak var addProductButton: UIButton!
    
    static let identifier = "SearchedProductCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func addProductToList(_ sender: UIButton){
        
    }
}
