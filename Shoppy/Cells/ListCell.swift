//
//  ListCell.swift
//  Shoppy-Falcone
//
//  Created by Fallon Falcone on 11/17/22.
//

import UIKit

class ListCell: UITableViewCell {
    
    @IBOutlet weak var listTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
