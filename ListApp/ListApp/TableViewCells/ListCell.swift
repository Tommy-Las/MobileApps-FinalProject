//
//  ListCell.swift
//  ListApp
//
//  Created by Tommy on 11/15/22.
//

import UIKit

class ListCell: UITableViewCell {

    @IBOutlet weak var listName: UILabel!
    @IBOutlet weak var removeListButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

   
    @IBAction func onRemoveList(_ sender: Any) {
        print("test");
    }
}
